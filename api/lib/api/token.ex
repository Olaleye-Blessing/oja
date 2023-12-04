defmodule Api.Token do
  use Joken.Config

  # 3 days
  @expiry 60 * 60 * 24 * 3

  @doc """
  Returns the default configuration for the token.
  """
  @spec token_config() :: map()
  def token_config, do: default_claims(default_exp: @expiry)

  @doc """
  Returns the default expiry for the token.
  """
  @spec expiry() :: integer()
  def expiry, do: @expiry
end
