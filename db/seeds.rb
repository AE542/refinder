require 'faker'
require 'fileutils'

# Array of item names
item_names = ['bag', 'camera', 'earphone', 'hat', 'idcard', 'keys', 'passport', 'sunglass', 'umbrella', 'watch', 'book', 'creditcard', 'glove', 'headphone', 'jewellery', 'laptop', 'phone', 'tablet', 'wallet'].shuffle

# Original names array with duplicates
names_group = [
  "John", "Emma", "Liam", "Olivia", "Noah", "Ava", "William", "Sophia", "James", "Isabella",
  "Benjamin", "Mia", "Lucas", "Charlotte", "Henry", "Amelia", "Alexander", "Harper", "Daniel"
]

# Remove duplicates and retrieve original names list
names = names_group.uniq

# lewagon_lon = -0.0760
# lewagon_lat = 51.5287
lewagon_lat = 51.5287
lewagon_lon = -0.0760

# Number of locations to generate
num_locations = 19

# Function to generate unique random locations
def generate_locations(lewagon_lat, lewagon_lon, num_locations)
  locations = []
  radius = 0.5 / 111.12 # Radius in degrees for approximately 0.5km distance

  while locations.length < num_locations
    lat = lewagon_lat + rand(-radius..radius)
    lon = lewagon_lon + rand(-radius..radius)

    # Check if the generated location is already in the array
    next if locations.any? { |loc| loc[0] == lat && loc[1] == lon }

    locations << [lat, lon]
  end
  locations
end

# Generate unique locations
locations = generate_locations(lewagon_lat, lewagon_lon, num_locations)

# Create 19 users with items
19.times do |index|
  lat, lon = locations[index]

  email = "#{names[index].downcase}@themail.com"
  user = User.create!(
    email: email,
    password: 'password'
  )

  item_name = item_names.pop

  item_image = Rails.root.join('db', 'seed_images_2', "#{item_name}.jpeg")
  item = user.items.create!(
    name: item_name,
    status: index < 9 ? 0 : 1, # Set status as lost (0) or found (1)
    source: 0,
    date: Faker::Date.between(from: 1.month.ago, to: Date.today),
    category: rand(0..9),
    latitude: lat,
    longitude: lon
  )
  item.image.attach(io: File.open(item_image), filename: "#{item_name}.jpeg", content_type: 'image/jpeg')
  item.save!

  puts "Created user #{email} with item: #{item.name} (#{index < 9 ? 'lost' : 'found'})"
end
