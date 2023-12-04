defmodule Api.Utils do
  @moduledoc """
  Contains utilities function used generally in the app
  """

  @doc """
  Convert changeset errors to a map with the field name as the key

  ## Examples
  iex> changeset_error_to_map(%Ecto.Changeset{errors: [%{name: "can't be blank"}]})
  %{name: ["can't be blank"]}

  iex> changeset_error_to_map(%Ecto.Changeset{errors: [%{name: "can't be blank"}, %{name: "is invalid"}]})
  %{name: ["can't be blank", "is invalid"]}
  """
  @spec changeset_error_to_map(Ecto.Changeset.t()) :: map()
  def changeset_error_to_map(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Regex.replace(~r"%{(\w+)}", message, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end

  @doc """
  Convert changeset errors to a single string

  ## Examples
  iex> changeset_error_to_string(%Ecto.Changeset{errors: [%{name: "can't be blank"}]})
  "name: can't be blank\n"

  iex> changeset_error_to_string(%Ecto.Changeset{errors: [%{name: "can't be blank"}, %{name: "is invalid"}]})
  "name: can't be blank; is invalid\n"
  """
  @spec changeset_error_to_string(Ecto.Changeset.t()) :: String.t()
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

  ## Examples
  iex> schema_to_map(%{__meta__: "test", name: "test", description: "test", price: 100})
  %{name: "test", description: "test", price: 100}

  iex> schema_to_map(%{__meta__: "test", name: "test", description: "test", price: 100}, [:price])
  %{name: "test", description: "test"}
  """
  @spec schema_to_map(Ecto.Schema.t(), list()) :: map()
  def schema_to_map(schema, keys \\ []) do
    schema
    |> Map.from_struct()
    |> Map.drop([:__meta__ | keys])
  end

  @doc """
  Extracts the specified fields from the body parameters.

  ## Examples
  iex> extract_fields([:name, :description], %{name: "test", description: "test", price: 100})
  %{name: "test", description: "test"}
  """
  @spec extract_fields(list(), map()) :: map()
  def extract_fields(fields, body_params) do
    Enum.into(fields, %{}, fn field ->
      {field, Map.get(body_params, to_string(field))}
    end)
  end
end
