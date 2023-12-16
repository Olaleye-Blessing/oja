defmodule Api.Dbs.Accounts do
  @moduledoc false

  alias Api.Dbs.Accounts.{User, UserToken}
  alias Api.Repo

  def register(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Login a user
  """
  @spec login(%{email: String.t(), password: String.t()}) ::
          {:ok, User.t()} | {:error, String.t()}
  def login(%{email: email, password: password}) do
    invalid_msg = {:error, "Incorrect email or password"}

    case Repo.get_by(User, %{email: email}) do
      nil ->
        invalid_msg

      user ->
        if Pbkdf2.verify_pass(password, user.password) do
          {:ok, user}
        else
          invalid_msg
        end
    end
  end

  @doc """
  Generate a refresh token for a user
  """
  @spec generate_refresh_token(User.t()) :: String.t()
  def generate_refresh_token(user) do
    {token, user_token} = UserToken.build_refresh_token(user)

    Repo.insert!(user_token)
    token
  end

  @doc """
  Get a user refresh token
  """
  @spec get_user_refresh_token(User.t()) :: UserToken.t() | nil
  def get_user_refresh_token(user) do
    Repo.get_by(UserToken, user_id: user.id, context: "refresh_token")
  end

  @doc """
  Delete a user refresh token
  """
  @spec delete_user_refresh_token(User.t()) ::
          {:ok, Ecto.Schema.t()} | {:error, Ecto.Changeset.t()}
  def delete_user_refresh_token(user) do
    user = user |> get_user_refresh_token()

    if user do
      Repo.delete(user)
    else
      {:error, nil}
    end
  end

  @doc """
  Get a user by id
  """
  @spec get(String.t()) :: User.t() | nil
  def get(user_id) do
    Repo.get(User, user_id)
  end

  @doc """
  Get a user by id and preloads needed associated tables.
  """
  @spec get(String.t()) :: User.t() | nil
  def get_full_detail(user_id, preloads) do
    Repo.get(User, user_id) |> Repo.preload(preloads)
  end

  def update_password(user, password) do
    user
    |> User.password_changeset(%{password: password})
    |> Repo.update()
  end
end
