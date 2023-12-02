import Ecto.Query

alias Api.Repo
alias Api.Dbs.Accounts.User
alias Api.Dbs.Items.Products
alias Api.Dbs.Purchases

# get all users and pick the first one
user = Repo.all(User) |> hd()

# get all products and pick the 3
[product1, product2, product3] = Repo.all(Products) |> Enum.take(3)

purchase_info = %{
  status: "pending",
  user_id: user.id,
  shipping_address: %{
    country: "Brazil",
    state: "São Paulo",
    city: "São Paulo",
    zip_code: "00000-000",
    address: "Rua dos Bobos, 0",
    full_name: "John Doe"
  },
  products: [
    %{
      quantity: 1,
      price: product1.price,
      product_id: product1.id
    },
    %{
      quantity: 2,
      price: product2.price,
      product_id: product2.id
    },
    %{
      quantity: 3,
      price: product3.price,
      product_id: product3.id
    }
  ],
  total_price: ((product1.price |> Decimal.mult(1) |> Decimal.to_float()) * 100 +
               (product2.price |> Decimal.mult(2) |> Decimal.to_float()) * 100 +
               (product3.price |> Decimal.mult(3) |> Decimal.to_float()) * 100) / 100
}
IO.inspect(Purchases.create_purchase_info(purchase_info))

User
|> Repo.all()
|> Repo.preload([purchases: [products: :product]])
|> IO.inspect()
