defmodule Api.Seeds.Users do
  @moduledoc """
  Seeds for the User schema.
  """

  alias Api.Dbs.Accounts

  def seed() do
    Enum.map(details(), fn detail ->
      Accounts.register(detail)
    end)
  end

  defp details() do
    [
      %{
        username: "jjj",
        email: "zidage@gmail.com",
        password: "Aa1234_"
      },
      %{
        username: "yea",
        email: "wyzikynywa@mailinator.com",
        password: "Aa1234_"
      },
      %{
        username: "yo",
        email: "yo@gmail.com",
        password: "Aa1234_"
      }
    ]
  end
end
