defmodule Api.Dbs.Accounts.User do
  @moduledoc false
  use Ecto.Schema

  import Ecto.Changeset

  @type t :: %__MODULE__{}

  @required_fields ~w(username email password)a
  @optional_fields ~w(avatar_url bio website phone_number city state country tiktok twitter instagram)a

  def meta_data_fields(), do: @optional_fields

  schema "users" do
    field(:username, :string)
    field(:email, :string)
    field(:password, :string, redact: true)
    # Personal
    field(:avatar_url, :string)
    field(:bio, :string)
    # contact
    field(:website, :string)
    field(:phone_number, :string)
    # location
    field(:city, :string)
    field(:state, :string)
    field(:country, :string)
    # socials
    field(:tiktok, :string)
    field(:twitter, :string)
    field(:instagram, :string)

    has_many(:products, Api.Dbs.Catalog.Product)
    has_many(:orders, Api.Dbs.Order.Order)

    many_to_many(:watched_products, Api.Dbs.Catalog.Product, join_through: "watchers")

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

  @doc """
  Changeset for changing a user password
  """
  @spec changeset(user :: __MODULE__.t(), params :: %{password: String.t()}) :: Ecto.Changeset.t()
  def password_changeset(user, params) do
    user
    |> cast(params, [:password])
    |> validate_password()
    |> hash_password()
  end

  @doc """
  Changeset for updating non-security fields.
  """
  @spec changeset(user :: __MODULE__.t(), params :: map()) :: Ecto.Changeset.t()
  def meta_data_changeset(user, params) do
    user
    |> cast(params, @optional_fields)
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
