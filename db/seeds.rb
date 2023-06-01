# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Array of item names
item_names = ["phone", "ring", "wallet", "license", "docs", "laptop", "bag", "watch"]
# Array of 50 London postcodes
london_postcodes = [
  "E1 7AA", "E1 7AB", "E1 7AD", "E1 7AE", "E1 7AF", "E1 7AG", "E1 7AH", "E1 7AJ", "E1 7AL", "E1 7AN",
  "E1 7AP", "E1 7AQ", "E1 7AR", "E1 7AS", "E1 7AT", "E1 7AU", "E1 7AW", "E1 7AX", "E1 7AY", "E1 7AZ",
  "E1 7BA", "E1 7BB", "E1 7BD", "E1 7BE", "E1 7BF", "E1 7BG", "E1 7BH", "E1 7BJ", "E1 7BL", "E1 7BN",
  "E1 7BP", "E1 7BQ", "E1 7BS", "E1 7BT", "E1 7BU", "E1 7BW", "E1 7BX", "E1 7BY", "E1 7BZ", "E1 7DA",
  "E1 7DB", "E1 7DD", "E1 7DE", "E1 7DF", "E1 7DG", "E1 7DH", "E1 7DJ", "E1 7DL", "E1 7DN"
]
# Array of lorem ipsum descriptions
lorem_ipsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
# Create 100 users
puts "creating seeds"

10.times do |n|
  email = "a#{n + 1}@a#{n + 1}.com"
  user = User.create!(
    email: email,
    password: 'password'
  )
  # Create a lost item
  lost_item = user.items.create!(
    name: item_names.sample,
    status: 0,
    description: lorem_ipsum,
    reward: rand(10..100),
    source: 0,
    date: Faker::Date.between(from: 1.month.ago, to: Date.today),
    category: rand(0..9),
    location: london_postcodes.sample
  )
  # Create a found item
  found_item = user.items.create!(
    name: item_names.sample,
    status: 1,
    description: lorem_ipsum,
    source: 0,
    date: Faker::Date.between(from: 1.month.ago, to: Date.today),
    category: rand(0..9),
    location: london_postcodes.sample
  )
  puts "Created user #{email} with items: #{lost_item.name} (lost) and #{found_item.name} (found)"
end
