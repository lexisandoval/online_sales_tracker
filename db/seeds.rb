# Seed 3 example users
lexi = User.create(name: "lexi", email:"lexi@gmail.com", password: "lexi")
nikki = User.create(name: "nikki", email:"nikki@gmail.com", password: "nikki")
ivan = User.create(name: "ivan", email:"ivan@gmail.com", password: "ivan")

# and 6 example sales
lexi.sales.create(title: "Nikes", amount: "60.75")
lexi.sales.create(title: "Depop", amount: "21.49")

nikki.sales.create(title: "Poshmark", amount: "40.12")
nikki.sales.create(title: "Red Shirt", amount: "15")

ivan.sales.create(title: "Airpods", amount: "90.98")
ivan.sales.create(title: "Ebay", amount: "30.50")
