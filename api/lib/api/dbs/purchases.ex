defmodule Api.Dbs.Purchases do
  @moduledoc false

  alias Api.Repo
  alias Api.Dbs.Purchases.Purchases, as: PurchasesSchema

  def create_purchase_info(params) do
    %PurchasesSchema{}
    |> PurchasesSchema.changeset(params)
    |> Repo.insert()
  end
end
