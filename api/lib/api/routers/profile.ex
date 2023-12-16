defmodule Api.Routers.Profile do
  # TODO: Decided if there should be another table and context for profile
  @moduledoc """
  Routes for user's activities that are not related to authentication
  """

  use Plug.Router

  alias Api.Controllers.Profile

  plug(:match)
  plug(:dispatch)

  get "/:id" do
    Profile.get_full_user_detail(conn)
  end
end
