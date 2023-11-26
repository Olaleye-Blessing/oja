defmodule Api.Dbs.Accounts.UserToken do
  @moduledoc """
  Token for users
  """

  use Ecto.Schema

  alias Api.Dbs.Accounts.UserToken

  @rand_size 32

  schema "users_tokens" do
    field(:token, :string)
    # refresh, password reset...
    field(:context, :string)
    belongs_to(:user, Api.Dbs.Accounts.User)

    timestamps(updated_at: false)
  end

  def build_token(user, context, token) do
    {token, %UserToken{token: token, context: context, user_id: user.id}}
  end

  def build_token(user, context) do
    build_token(user, context, :crypto.strong_rand_bytes(@rand_size))
  end

  def build_refresh_token(user) do
    build_token(user, "refresh_token", Api.Token.generate_and_sign!(%{"user_id" => user.id}))
  end
end
