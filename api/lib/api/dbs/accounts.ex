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
  Get the a user refresh token
  """
  @spec get_user_refresh_token(User.t()) :: UserToken.t() | nil
  def get_user_refresh_token(user) do
    Repo.get_by(UserToken, user_id: user.id, context: "refresh_token")
  end

  @doc """
  Get a user by id
  """
  @spec get(String.t()) :: User.t() | nil
  def get(user_id) do
    Repo.get(User, user_id)
  end
end
