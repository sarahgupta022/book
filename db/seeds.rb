# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

DEFAULT_INSECURE_PASSWORD = 'arvind@22'

User.create({
  first_name: "Arvind",
  last_name: "Kumar",
  profile_name: "arvind",
  email: "arvind.krg@gmail.com",
  password: DEFAULT_INSECURE_PASSWORD,
  password_confirmation: DEFAULT_INSECURE_PASSWORD
})

User.create({
  first_name: "Sarah",
  last_name: "Gupta",
  profile_name: "sarahgupta",
  email: "sarahgupta022@gmail.com",
  password: DEFAULT_INSECURE_PASSWORD,
  password_confirmation: DEFAULT_INSECURE_PASSWORD
})

User.create({
  first_name: "Ruby",
  last_name: "Gupta",
  profile_name: "ruby",
  email: "rubs27feb@gmail.com",
  password: DEFAULT_INSECURE_PASSWORD,
  password_confirmation: DEFAULT_INSECURE_PASSWORD
})

User.create({
  first_name: "Ruby",
  last_name: "Gupta",
  profile_name: "biry",
  email: "rubygupta027@gmail.com",
  password: DEFAULT_INSECURE_PASSWORD,
  password_confirmation: DEFAULT_INSECURE_PASSWORD
})

User.create({
  first_name: "Premlata",
  last_name: "Devi",
  profile_name: "premlata",
  email: "premlatadevi.cwc@gmail.com",
  password: DEFAULT_INSECURE_PASSWORD,
  password_confirmation: DEFAULT_INSECURE_PASSWORD
})

sarah = User.find_by_email('sarahgupta022@gmail.com')
ruby   = User.find_by_email('rub27feb@gmail.com.com')
ruby = User.find_by_email('rubygupta027@gmail.com')
arvind  = User.find_by_email('arvind.krg@gmail.com')
premlata  = User.find_by_email('premlatadevi.cwc@gmail.com')

seed_user = sarah

seed_user.statuses.create(context: "Hello, world!")
ruby.statuses.create(context: "Hi, I'm Rubs")
ruby.statuses.create(context: "Hello from the internet!!")
arvind.statuses.create(context: "I want to learn html javapress")
premlata.statuses.create(context: "Friendsbook is awesome!")

UserFriendship.request(seed_user, ruby).accept!
UserFriendship.request(seed_user, ruby).block!
UserFriendship.request(seed_user, arvind)
UserFriendship.request(premlata, seed_user)