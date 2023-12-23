defmodule Api.Routers.Profile do
  # TODO: Decided if there should be another table and context for profile
  @moduledoc """
  Routes for user's activities that are not related to authentication
  """

  use Plug.Router

  import Api.Plugs.Authentication

  alias Api.Controllers.Profile

  plug(:authenticated, %{profiles: true})
  plug(:authenticate_owner, %{profiles: ["PATCH"]})

  plug(:match)
  plug(:dispatch)

  get "/:id" do
    Profile.get_full_user_detail(conn)
  end

  patch "/:id" do
    Profile.update(conn)
  end

  # Protect routes to make sure the person making this change is really the owner of the account.
  defp authenticate_owner(conn, %{profiles: methods}), do: protect_owner_path(conn, methods)

  defp authenticate_owner(conn, _opts), do: conn

  defp protect_owner_path(conn, methods) do
    if Map.get(conn, :method) in methods do
      is_owner(conn)
    else
      conn
    end
  end

  defp is_owner(%{path_info: [user_id | _], assigns: %{current_user: user}} = conn) do
    if String.to_integer(user_id) == user.id do
      conn
    else
      Api.Router.json_resp(
        :error,
        halt(conn),
        "You are not authorized to perform this action!",
        403
      )
    end
  end
end
