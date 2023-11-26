defmodule Api.Dbs.Accounts do
  @moduledoc false

  alias Api.Dbs.Accounts.User
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

  def get(user_id) do
    Repo.get(User, user_id)
  end
end
