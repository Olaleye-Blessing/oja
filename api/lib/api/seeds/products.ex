defmodule Api.Seeds.Products do
  @moduledoc """
  Seeds for the Product schema.
  """

  alias Api.Repo
  alias Api.Dbs.Accounts.User
  alias Api.Dbs.Catalog.Category
  alias Api.Dbs.Catalog

  def seed() do
    [user_1, user_2, user_3] = Repo.all(User)
    categories = Repo.all(Category)

    products = get_products(user_1, user_2, user_3, categories)

    Enum.each(products, fn product ->
      Catalog.create_product(product.user_id, product.category_id, product)
      IO.inspect(" 🌱 Seeded product #{product.name}")
      Process.sleep(1_000)
    end)
  end

  defp get_products(user_1, user_2, user_3, categories) do
    [
      %{
        name: "Apple iPhone 11 Pro Max",
        description:
          "Apple iPhone 11 Pro Max - 256GB - Midnight Green (Unlocked) A2161 (CDMA + GSM)",
        price: 1000.00,
        stock_quantity: 10,
        condition: "new",
        user_id: user_1,
        category_id: Enum.at(categories, 1),
        image: "https://i.ebayimg.com/images/g/GbEAAOSwJ8Jg4Dc3/s-l1600.jpg"
      },
      %{
        name: "Books by Genre 10 LBS~Pounds Lot Sorted Fiction/Nonfiction CHOOSE YOUR CATEGORY",
        price: 20.00,
        stock_quantity: 40,
        condition: "used",
        user_id: user_2,
        category_id: Enum.at(categories, 0),
        image: "https://i.ebayimg.com/images/g/fbMAAOSwA7Fjp05g/s-l1600.jpg"
      },
      %{
        name: "Fashion Cubic Zirconia Pearl Earrings for Women Girl Party Wedding Jewelry Gifts",
        description:
          "New without tags: A brand-new, unused, and unworn item (including handmade items) that is not in original packaging or may be missing original packaging materials (such as the original box or bag). The original tags may not be attached.",
        price: 5.00,
        stock_quantity: 100,
        condition: "new",
        user_id: user_3,
        category_id: Enum.at(categories, 2),
        image: "https://i.ebayimg.com/images/g/PWEAAOSwp8NlOkn0/s-l1600.jpg"
      },
      %{
        name:
          "Felt glider round Ø 15-62 mm self-adhesive | 6 mm thick | high adhesive force | from 4 pcs",
        description:
          "New: A brand-new, unused, unopened, undamaged item in its original packaging (where packaging is applicable). Packaging should be the same as what is found in a retail store, unless the item is handmade or was packaged by the manufacturer in non-retail packaging, such as an unprinted box or plastic bag. See the seller's listing for full details. ",
        price: 5.00,
        stock_quantity: 100,
        condition: "new",
        user_id: user_3,
        category_id: Enum.at(categories, 3),
        image: "https://i.ebayimg.com/images/g/FswAAOSwlHRXI19a/s-l1600.jpg"
      },
      %{
        name: "Kirkland 3 Piece Golf Wedge Gap Sand Lob Set Right Handed High Performance",
        description: "",
        price: 100.00,
        stock_quantity: 10,
        condition: "used",
        user_id: user_1,
        category_id: Enum.at(categories, 4),
        image: "https://i.ebayimg.com/images/g/odoAAOSw4iFh-JwX/s-l1600.jpg"
      },
      %{
        name: "Disney Lilo and Stitch Big Mouth Bite Finger Game Figure Key Chain Holder Toy",
        description: "",
        price: 5.00,
        stock_quantity: 100,
        condition: "new",
        user_id: user_2,
        category_id: Enum.at(categories, 5),
        image: "https://i.ebayimg.com/images/g/IygAAOSw8L5cD-Ek/s-l1600.jpg"
      },
      %{
        name: "Vestidos Off Shoulder Para Mujer Largos Casuales De Fiesta Elegantes Noche Dress",
        description: "",
        price: 20.00,
        stock_quantity: 40,
        condition: "used",
        user_id: user_3,
        category_id: Enum.at(categories, 6),
        image: "https://i.ebayimg.com/images/g/e-UAAOSwGaJhFyhs/s-l1600.jpg"
      },
      %{
        name: "NWT Men's and Women's Classic Croc All Terrain Clogs Waterproof Slip On Shoes",
        description: "",
        price: 20.00,
        stock_quantity: 40,
        condition: "new",
        user_id: user_1,
        category_id: Enum.at(categories, 7),
        image: "https://i.ebayimg.com/images/g/qd4AAOSwhzRlCKIq/s-l1600.jpg"
      },
      %{
        name: "USB Car Accessories Interior Atmosphere Star Sky Lamp Ambient Night Lights US",
        description: "",
        price: 5.00,
        stock_quantity: 100,
        condition: "used",
        user_id: user_2,
        category_id: Enum.at(categories, 8),
        image: "https://i.ebayimg.com/images/g/t9MAAOSwGcNjMQPJ/s-l1600.jpg"
      },
      %{
        name: "TANK CHAIN 2mm - 10mm Solid Stainless Steel Necklace 30cm - 120cm Men's Women",
        description: "",
        price: 25.00,
        stock_quantity: 20,
        condition: "new",
        user_id: user_3,
        category_id: Enum.at(categories, 9),
        image: "https://i.ebayimg.com/images/g/81wAAOSwpTFgLPsO/s-l1600.jpg"
      },
      %{
        name: "Waterproof Men's Watch Stainless Steel Quartz Luminous Classic Watches",
        description: "",
        price: 320.75,
        stock_quantity: 10,
        condition: "new",
        user_id: user_1,
        category_id: Enum.at(categories, 10),
        image: "https://i.ebayimg.com/images/g/qtQAAOSw3ktg23eq/s-l1600.jpg"
      },
      %{
        name: "NOW FOODS Vitamin K-2 100 mcg - 100 Veg Capsules",
        description: "",
        price: 10.46,
        stock_quantity: 100,
        condition: "new",
        user_id: user_2,
        category_id: Enum.at(categories, 11),
        image: "https://i.ebayimg.com/images/g/9IgAAOSwWo9gpYE0/s-l1600.jpg"
      },
      %{
        name: "All Sets and Knifes | MM2 | Murder Mystery 2 | Roblox",
        description: "",
        price: 12.96,
        stock_quantity: 30,
        condition: "used",
        user_id: user_3,
        category_id: Enum.at(categories, 12),
        image: "https://i.ebayimg.com/images/g/bTIAAOSwmlVkuoUC/s-l1600.png"
      },
      %{
        name: "Digital Image Picture Photo Wallpaper Background Desktop Art Misti",
        description: "",
        price: 0.99,
        stock_quantity: 130,
        condition: "new",
        user_id: user_1,
        category_id: Enum.at(categories, 13),
        image: "https://i.ebayimg.com/images/g/ct0AAOSw3e5lKjJb/s-l1600.jpg"
      },
      %{
        name: "Wooden Beads, Christmas, Red Green, White Mixed ,Round Craft , 8mm x 100 W43",
        description: "",
        price: 1.99,
        stock_quantity: 9,
        condition: "used",
        user_id: user_2,
        category_id: Enum.at(categories, 14),
        image: "https://i.ebayimg.com/images/g/DdkAAOSwuG9cbWCB/s-l1600.jpg"
      },
      %{
        name: "4Pcs/Set Women Lady Leather Handbags Messenger Shoulder Bags Tote Satchel Purse",
        description: "",
        price: 14.99,
        stock_quantity: 94,
        condition: "new",
        user_id: user_3,
        category_id: Enum.at(categories, 15),
        image: "https://i.ebayimg.com/images/g/r8EAAOSwhy5kxabN/s-l1600.png"
      },
      %{
        name: "NEW 6 STRING CLASSIC Tele STYLE NATURAL FINISH ELECTRIC GUITAR LIGHTWEIGHT",
        description: "",
        price: 134.99,
        stock_quantity: 94,
        condition: "new",
        user_id: user_3,
        category_id: Enum.at(categories, 16),
        image: "https://i.ebayimg.com/images/g/QJoAAOSwl9FjEK2B/s-l1600.jpg"
      }
    ]
  end
end
