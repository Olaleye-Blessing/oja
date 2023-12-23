defmodule Api.Controllers.Profile do
  @moduledoc """
  Contains functions for user activities not related to authentication
  """
  alias Api.{Router, Utils}
  alias Api.Dbs.Accounts
  alias Api.Dbs.Accounts.User

  @common_preloads [:products]

  @doc """
  Update user's profile info
  """
  @spec update(Plug.Conn.t()) :: Plug.Conn.t()
  def update(%{body_params: body_params, assigns: %{current_user: user}} = conn) do
    accepted_fields = User.meta_data_fields()

    body_params =
      body_params
      |> Enum.filter(fn {key, _v} -> String.to_atom(key) in accepted_fields end)
      |> Enum.into(%{})

    case Accounts.update_meta_data(user, body_params) do
      {:ok, updated_user} ->
        Router.json_resp(
          :ok,
          conn,
          Utils.schema_to_map(updated_user, [:products, :orders, :watched_products, :password]),
          200
        )

      {:error, changeset} ->
        Router.json_resp(:error, conn, Utils.changeset_error_to_string(changeset), 400)
    end
  end

  @spec get_full_user_detail(Plug.Conn.t()) :: Plug.Conn.t()
  def get_full_user_detail(
        %{path_params: %{"id" => user_id}, assigns: %{current_user: current_user}} = conn
      ) do
    personal_account? = current_user && current_user.id == String.to_integer(user_id)

    preloads =
      if personal_account? do
        [:watched_products, :orders] ++ @common_preloads
      else
        @common_preloads
      end

    case user_id |> Accounts.get_full_detail(preloads) do
      nil ->
        Router.json_resp(:error, conn, "Account does not exist!", 404)

      user ->
        Router.json_resp(:ok, conn, user |> format_user(personal_account?), 200)
    end
  end

  defp format_user(user, personal_account?) do
    IO.inspect(user)

    products =
      user.products
      |> Enum.map(fn product ->
        Utils.schema_to_map(product, [:category, :user, :watchers])
      end)

    watched_products =
      if personal_account? do
        user.watched_products
        |> Enum.map(fn product ->
          Utils.schema_to_map(product, [:category, :user, :watchers])
        end)
      else
        []
      end

    user =
      Utils.schema_to_map(user, [:products, :orders, :watched_products])
      |> Map.put(:products, products)

    if personal_account? do
      user
      |> Map.merge(%{watched_products: watched_products})
    else
      user
    end
  end
end
