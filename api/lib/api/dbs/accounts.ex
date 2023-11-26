defmodule Api.Dbs.Accounts do
  @moduledoc false

  alias Api.Dbs.Accounts.{User, UserToken}
  alias Api.Repo

  def register(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

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

  def update_refresh_token(user, token) do
    user |> User.refresh_token_changeset(token) |> Repo.update()
  end

  def generate_refresh_token(user) do
    {token, user_token} = UserToken.build_refresh_token(user)

    Repo.insert!(user_token)
    token
  end

  def get_user_refresh_token(user) do
    Repo.get_by(UserToken, user_id: user.id, context: "refresh_token")
  end

  def get(user_id) do
    Repo.get(User, user_id)
  end
end
