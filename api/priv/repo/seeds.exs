alias Api.Seeds.{Users, Categories, Products, Watchers}

[Users, Categories, Products, Watchers] |> Enum.map(&(&1.seed()))
