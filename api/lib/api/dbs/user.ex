defmodule API.Dbs.User do
  @moduledoc false

  alias API.Dbs.User.Schema
  alias Api.Repo

  def register(attrs) do
    %Schema{}
    |> Schema.changeset(attrs)
    |> Repo.insert()
  end
end
