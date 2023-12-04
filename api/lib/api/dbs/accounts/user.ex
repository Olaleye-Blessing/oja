defmodule Api.Dbs.Accounts.User do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @type t :: %__MODULE__{}

  @required_fields ~w(username email password)a

  schema "users" do
    field(:username, :string)
    field(:email, :string)
    field(:password, :string, redact: true)

    has_many(:products, Api.Dbs.Catalog.Product)
    has_many(:purchases, Api.Dbs.Cart.Purchase)

    timestamps()
  end

  @doc """
  Builds a changeset based for a user
  """
  @spec changeset(user :: __MODULE__.t(), params :: map()) :: Ecto.Changeset.t()
  def changeset(user, params) do
    user
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
    |> validate_email()
    |> validate_password()
    |> validate_username()
    |> hash_password()
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
