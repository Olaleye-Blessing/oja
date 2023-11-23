defmodule Api.Utils do
  @moduledoc """
  Contains utilities function used generally in the app
  """

  def changeset_error_to_map(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Regex.replace(~r"%{(\w+)}", message, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end

  @doc """
  Convert changeset errors to a single string
  """
  def changeset_error_to_string(changeset) do
    changeset
    |> changeset_error_to_map()
    |> Enum.reduce("", fn {k, v}, acc ->
      joined_errors = Enum.join(v, "; ")
      "#{acc}#{k}: #{joined_errors}\n"
    end)
  end

  @doc """
  Converts a schema to map by stripping off the `:meta` key and other provided keys
  """
  def schema_to_map(schema, keys \\ []) do
    schema
    |> Map.from_struct()
    |> Map.drop([:__meta__ | keys])
  end
end
