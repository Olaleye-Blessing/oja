defmodule Api.Token do
  use Joken.Config

  # 3 days
  def token_config, do: default_claims(default_exp: 60 * 60 * 24 * 3)
end
