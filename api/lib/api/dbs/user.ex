defmodule Api.Dbs.User do
  @moduledoc false

  alias Api.Dbs.User.Schema
  alias Api.Repo

  def register(attrs) do
    %Schema{}
    |> Schema.changeset(attrs)
    |> Repo.insert()
  end

  def login(%{email: email, password: password}) do
    invalid_msg = {:error, "Incorrect email or password"}

    case Repo.get_by(Schema, %{email: email}) do
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
    user |> Schema.refresh_token_changeset(token) |> Repo.update()
  end
end
