defmodule Api.Seeds.Watchers do
  @moduledoc """
  Seeds for watchers table.

  IT contains functions to add/remove products from a user's watched_products
  """

  alias Api.Repo
  alias Api.Dbs.Accounts.User
  alias Api.Dbs.Catalog.Product
  alias Api.Dbs.Catalog

  defp users() do
    Repo.all(User)
  end

  defp products() do
    Repo.all(Product)
  end

  def seed() do
    users = Repo.all(User)
    user_1 = Enum.at(users, 0)
    user_2 = Enum.at(users, 1)
    user_3 = Enum.at(users, 2)
    [product_1 | [product_2 | [product_3 | _other_products]]] = products()

    Catalog.watch_product(user_1, product_1)
    IO.inspect("🔥 user 1 watching product 1")
    Process.sleep(1_000)
    Catalog.watch_product(user_1, product_2)
    IO.inspect("🔥 user 1 watching product 2")
    Process.sleep(1_000)
    Catalog.watch_product(user_1, product_3)
    IO.inspect("🔥 user 1 watching product 3")
    Process.sleep(1_000)
    Catalog.watch_product(user_2, product_1)
    IO.inspect("🔥 user 2 watching product 1")
    Process.sleep(1_000)
    Catalog.watch_product(user_2, product_2)
    IO.inspect("🔥 user 2 watching product 2")
    Process.sleep(1_000)
    Catalog.watch_product(user_3, product_1)
    IO.inspect("🔥 user 3 watching product 1")

    # Invalid
    Catalog.watch_product(user_1, Map.put(product_1, :id, 1999))
  end
end
