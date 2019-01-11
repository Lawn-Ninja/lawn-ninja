# User.destroy_all
# Job.destroy_all
User.create(
  name: "Test User",
  email: "test@test.com",
  password: "password",
  password_confirmation: "password",
  address: Faker::Address.street_address,
  city: Faker::Address.city,
  state: Faker::Address.state_abbr,
  zip_code: 91101,
  phone_number: Faker::PhoneNumber.cell_phone,
  provider: true
)

Faker::Config.locale = 'en-US'

5000.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password",
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    zip_code: 60652,
    phone_number: Faker::PhoneNumber.cell_phone,
    provider: (rand(1..2) == 1)
  )
end

# FOR PASADENA-AREA DATA (NEAR 91101)
zip_codes_near_pasadena = ["91803", "91899", "91802", "91804", "91841", "91896", "91801", "91776", "91778", "91030", "91031", "90042", "91775", "90050", "91189", "91118", "91108", "91184", "91115", "91125", "91126", "90041", "91106", "91105", "91123", "91124", "91129", "91102", "91182", "91188", "91116", "91117", "91101", "91110", "91131", "91191", "91121", "91107", "91226", "91109", "91114", "91206", "91104", "91103", "91199", "91003", "91001", "91012"]

20.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: "password",
    password_confirmation: "password",
    address: Faker::Address.street_address,
    city: Faker::Address.city,
    state: Faker::Address.state_abbr,
    zip_code: zip_codes_near_pasadena.sample,
    phone_number: Faker::PhoneNumber.cell_phone,
    provider: (rand(1..2) == 1)
  )
end

statuses = ["posted", "claimed", "started", "completed"]
user_ids = User.all.ids
provider_ids = User.where(provider: true).ids

500000.times do
  # user_id, status, requested_time
  job_instance = Job.new(
    user_id: user_ids.sample,
    provider_id: nil,
    start_time: nil,
    end_time: nil,
    status: statuses.sample,
    requested_time: Time.now + rand(1..100).days + rand(0..23).hours + rand(0..59).minutes + rand(0..59).seconds
  )

  # provider_id
  if job_instance[:status] != "posted"
    while !job_instance[:provider_id] || job_instance[:user_id] == job_instance[:provider_id]
      job_instance[:provider_id] = provider_ids.sample
    end
  end

  # start_time
  if job_instance[:status] == "started" || job_instance[:status] == "completed"
    two_hour_window = rand(-3600..3600)
    job_instance[:start_time] = job_instance[:requested_time] + two_hour_window
  end

  # end_time
  if job_instance[:status] == "completed"
    job_duration = rand(900..7200)
    job_instance[:end_time] = job_instance[:start_time] + job_duration
  end

  job_instance.save
end