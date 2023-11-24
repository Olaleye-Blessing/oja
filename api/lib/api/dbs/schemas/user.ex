defmodule Api.Dbs.Schema.User do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  schema "users" do
    field(:username, :string)
    field(:email, :string)
    field(:password, :string, redact: true)
    # field(:password, :string)
    field(:refresh_token, :string)

    timestamps()
  end

  def changeset(user, params) do
    user
    |> cast(params, [:username, :email, :password])
    |> validate_required([:username, :email, :password])
    |> validate_email()
    |> validate_password()
    |> validate_username()
    |> hash_password()
  end

  def refresh_token_changeset(user, token) do
    user
    |> change(refresh_token: token)
  end

  defp validate_email(changeset) do
    changeset
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have @ sign and no spaces")
    |> validate_length(:email, max: 50)
    |> unsafe_validate_unique(:email, Api.Repo)
    |> unique_constraint(:email)
  end

  defp validate_password(changeset) do
    changeset
    |> validate_length(:password, min: 5)
    |> validate_format(:password, ~r/[a-z]/, message: "at least one lower case character")
    |> validate_format(:password, ~r/[A-Z]/, message: "at least one upper case character")
    |> validate_format(:password, ~r/[!?@#$%^&*_0-9]/,
      message: "at least one digit or punctuation character"
    )
  end

  defp validate_username(changeset) do
    changeset
    |> unsafe_validate_unique(:username, Api.Repo)
    |> unique_constraint(:username)
  end

  defp hash_password(changeset) do
    password = get_change(changeset, :password) || ""

    changeset
    |> put_change(:password, Pbkdf2.hash_pwd_salt(password))
  end
end
