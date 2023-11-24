import Ecto.Query
alias Api.Dbs.{User, Product}
alias Api.Repo
alias Api.Dbs.Schema.User, as: UserSchema

local_users = [
  %{
    username: "bikky",
    email: "bikky@gmail.com",
    password: "Test@1234_"
  },
  %{
    username: "jongbo",
    email: "jongbo@gmail.com",
    password: "Test@1234_"
  },
  %{
    username: "menu",
    email: "menu@gmail.com",
    password: "Test@1234_"
  }
]

# Enum.each(local_users, fn user -> User.register(user) end)

db_users_q = from UserSchema
db_users = Repo.all(db_users_q)

user_1 = Enum.at(db_users, 0)
user_2 = Enum.at(db_users, 1)
user_3 = Enum.at(db_users, 2)

# local_products = [
#   %{
#     name: "Smartphone X",
#     description: "High-performance smartphone with advanced features.",
#     price: 699.99,
#     stock_quantity: 100,
#     category: "Electronics",
#     condition: "new",
#     image: "https://images.unsplash.com/photo-1634403665481-74948d815f03?q=80&w=2787&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
#     user_id: user_1
#   },
#   %{
#     name: "Laptop Pro",
#     description: "Powerful laptop for professional use.",
#     price: 1499.99,
#     stock_quantity: 50,
#     category: "Electronics",
#     condition: "new",
#     image: "https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8bGFwdG9wfGVufDB8fDB8fHww",
#     user_id: user_2
#   },
#   %{
#     name: "Running Shoes",
#     description: "Comfortable and stylish running shoes.",
#     price: 89.99,
#     stock_quantity: 75,
#     category: "Footwear",
#     condition: "new",
#     image: "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c2hvZXN8ZW58MHx8MHx8fDA%3D",
#     user_id: user_3
#   },
#   %{
#     name: "Coffee Maker",
#     description: "Automatic coffee maker for your daily brew.",
#     price: 129.99,
#     stock_quantity: 30,
#     category: "Appliances",
#     condition: "new",
#     image: "https://images.unsplash.com/photo-1518057111178-44a106bad636?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8Y29mZmVlfGVufDB8fDB8fHww",
#     user_id: user_2
#   },
#   %{
#     name: "Graphic T-Shirt",
#     description: "Casual graphic t-shirt for everyday wear.",
#     price: 29.99,
#     stock_quantity: 120,
#     category: "Clothing",
#     condition: "new",
#     image: "https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dCUyMHNoaXJ0fGVufDB8fDB8fHww",
#     user_id: user_3
#   },
#   %{
#     name: "Wireless Headphones",
#     description: "Immersive sound experience with wireless convenience.",
#     price: 129.99,
#     stock_quantity: 60,
#     category: "Electronics",
#     condition: "new",
#     image: "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aGVhZHBob25lc3xlbnwwfHwwfHx8MA%3D%3D",
#     user_id: user_1
#   },
#   %{
#     name: "Dining Table",
#     description: "Elegant dining table for family gatherings.",
#     price: 499.99,
#     stock_quantity: 25,
#     category: "Furniture",
#     condition: "new",
#     image: "https://images.unsplash.com/photo-1615066390971-03e4e1c36ddf?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8ZGluaW5nJTIwdGFibGV8ZW58MHx8MHx8fDA%3D",
#     user_id: user_2
#   },
#   %{
#     name: "Digital Camera",
#     description: "Capture every moment with this high-resolution camera.",
#     price: 799.99,
#     stock_quantity: 40,
#     category: "Electronics",
#     condition: "new",
#     image: "https://images.unsplash.com/photo-1581591524425-c7e0978865fc?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZGlnaXRhbCUyMGNhbWVyYXxlbnwwfHwwfHx8MA%3D%3D",
#     user_id: user_3
#   },
#   %{
#     name: "Backpack",
#     description: "Spacious and durable backpack for your adventures.",
#     price: 49.99,
#     stock_quantity: 90,
#     category: "Fashion",
#     condition: "new",
#     image: "https://images.unsplash.com/photo-1553062407-98eeb64c6a62?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YmFja3BhY2t8ZW58MHx8MHx8fDA%3D",
#     user_id: user_1
#   },
#   %{
#     name: "Fitness Tracker",
#     description: "Monitor your health and stay active with this fitness tracker.",
#     price: 79.99,
#     stock_quantity: 35,
#     category: "Electronics",
#     condition: "new",
#     image: "https://images.unsplash.com/photo-1576243345690-4e4b79b63288?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8Zml0bmVzcyUyMHRyYWNrZXJ8ZW58MHx8MHx8fDA%3D",
#     user_id: user_2
#   },
#   %{
#     name: "Gaming Chair",
#     description: "Comfortable gaming chair for long gaming sessions.",
#     price: 199.99,
#     stock_quantity: 20,
#     category: "Gaming",
#     condition: "new",
#     image: "https://images.unsplash.com/photo-1619725002198-6a689b72f41d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Z2FtaW5nJTIwY2hhaXJ8ZW58MHx8MHx8fDA%3D",
#     user_id: user_1
#   },
#   %{
#     name: "HD Smart TV",
#     description: "Enjoy your favorite shows in stunning HD resolution.",
#     price: 899.99,
#     stock_quantity: 15,
#     category: "Electronics",
#     condition: "new",
#     image: "https://images.unsplash.com/photo-1611434597131-949cdb202148?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8SEQlMjBzbWFydCUyMHR2fGVufDB8fDB8fHww",
#     user_id: user_3
#   },
#   %{
#     name: "Sneakers",
#     description: "Classic sneakers for a casual and stylish look.",
#     price: 69.99,
#     stock_quantity: 80,
#     category: "Footwear",
#     condition: "new",
#     image: "https://images.unsplash.com/photo-1595950653106-6c9ebd614d3a?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c25lYWtlcnN8ZW58MHx8MHx8fDA%3D",
#     user_id: user_2
#   },
#   %{
#     name: "Blender",
#     description: "High-performance blender for smoothies and more.",
#     price: 79.99,
#     stock_quantity: 45,
#     category: "Appliances",
#     condition: "new",
#     image: "https://images.unsplash.com/photo-1585515320310-259814833e62?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8YmxlbmRlcnxlbnwwfHwwfHx8MA%3D%3D",
#     user_id: user_3
#   },
#   %{
#     name: "Leather Jacket",
#     description: "Timeless leather jacket for a rugged and stylish look.",
#     price: 149.99,
#     stock_quantity: 55,
#     category: "Clothing",
#     condition: "new",
#     image: "https://images.unsplash.com/photo-1521223890158-f9f7c3d5d504?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bGVhdGhlciUyMGphY2tldHxlbnwwfHwwfHx8MA%3D%3D",
#     user_id: user_1
#   },
#   %{
#     name: "Portable Speaker",
#     description: "Compact and portable speaker for on-the-go music.",
#     price: 39.99,
#     stock_quantity: 70,
#     category: "Electronics",
#     condition: "new",
#     image: "https://images.unsplash.com/photo-1608043152269-423dbba4e7e1?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8cG9ydGFibGUlMjBzcGVha2VyfGVufDB8fDB8fHww",
#     user_id: user_3
#   },
#   %{
#     name: "Desk Lamp",
#     description: "Modern desk lamp for a well-lit workspace.",
#     price: 29.99,
#     stock_quantity: 50,
#     category: "Home and Office",
#     condition: "new",
#     image: "https://images.unsplash.com/photo-1505771215590-c5fa0aec29b8?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8ZGFyayUyMGxhbXB8ZW58MHx8MHx8fDA%3D",
#     user_id: user_1
#   },
#   %{
#     name: "Yoga Mat",
#     description: "Comfortable yoga mat for your daily practice.",
#     price: 19.99,
#     stock_quantity: 65,
#     category: "Fitness",
#     condition: "new",
#     image: "https://images.unsplash.com/photo-1637157216470-d92cd2edb2e8?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8eW9nYSUyMG1hdHxlbnwwfHwwfHx8MA%3D%3D",
#     user_id: user_2
#   },
#   %{
#     name: "Air Fryer",
#     description: "Healthy cooking with this efficient air fryer.",
#     price: 129.99,
#     stock_quantity: 40,
#     category: "Appliances",
#     condition: "new",
#     image: "https://images.unsplash.com/photo-1617775047746-5b36a40109f5?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8YWlyJTIwZnJ5ZXJ8ZW58MHx8MHx8fDA%3D",
#     user_id: user_3
#   },
#   %{
#     name: "Smart Watch",
#     description: "Stay connected with this feature-packed smartwatch.",
#     price: 159.99,
#     stock_quantity: 30,
#     category: "Electronics",
#     condition: "new",
#     image: "https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8c21hcnQlMjB3YXRjaHxlbnwwfHwwfHx8MA%3D%3D",
#     user_id: user_1
#   },
#   %{
#     name: "Office Chair",
#     description: "Ergonomic office chair for a comfortable workday.",
#     price: 119.99,
#     stock_quantity: 25,
#     category: "Home and Office",
#     condition: "new",
#     image: "https://images.unsplash.com/photo-1633789638578-eef0da1dc063?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8b2ZmaWNlJTIwY2hhaXJ8ZW58MHx8MHx8fDA%3D",
#     user_id: user_2
#   },
#   %{
#     name: "Guitar",
#     description: "Quality acoustic guitar for aspiring musicians.",
#     price: 299.99,
#     stock_quantity: 15,
#     category: "Musical Instruments",
#     condition: "new",
#     image: "https://images.unsplash.com/photo-1525201548942-d8732f6617a0?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Z3VpdGFyfGVufDB8fDB8fHww",
#     user_id: user_3
#   },
# ]

# Enum.each(local_products, fn p ->
#   user = p.user_id

#   new_product = Ecto.build_assoc(user, :products, Map.delete(p, :user_id))

#   Repo.insert(new_product)
# end)

IO.inspect("___________")
IO.inspect(user_3.id)
IO.inspect("___________")

test = %{
    name: "Guitar",
    description: "Quality acoustic guitar for aspiring musicians.",
    price: 1,
    stock_quantity: 2,
    category: "Musical Instruments",
    condition: "new",
    image: "https://images.unsplash.com/photo-1525201548942-d8732f6617a0?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Z3VpdGFyfGVufDB8fDB8fHww",
    # user_id: user_3.id
}

# user_3
# |> Ecto.build_assoc(:products, test)
# |> Repo.insert()

Product.create(test, user_1)
Product.create(test, user_2)
Product.create(test, user_3)
