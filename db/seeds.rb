# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



def craete_groups
  puts "Creating groups"
  10.times do |n|
    Group.create name: "Group#{n}",
                  lat: 37.8670800,
                  lng: -122.2556760
    puts "Created school #{n}"
  end
end


def make_groups
  Group.create! name: 'Movies', description: 'yo', neighborhood_id: 1, kind: 1
  Group.create! name: 'Knitting', description: 'yo', neighborhood_id: 1, kind: 0
  Group.create! name: 'Computer', description: 'yo', neighborhood_id: 1, kind: 2
  Group.create! name: 'Poker', description: 'yo', neighborhood_id: 1, kind: 0
  Group.create! name: 'Bingo', description: 'yo', neighborhood_id: 1, kind: 1
  Group.create! name: 'Music', description: 'yo', neighborhood_id: 1, kind: 2
  Group.create! name: 'Reading', description: 'yo', neighborhood_id: 1, kind: 0
  Group.create! name: 'Politics', description: 'yo', neighborhood_id: 2, kind: 1
  Group.create! name: 'Education', description: 'yo', neighborhood_id: 2, kind: 2
  Group.create! name: 'Kites', description: 'yo', neighborhood_id: 2, kind: 0
  Group.create! name: 'Pool', description: 'yo', neighborhood_id: 2, kind: 1
  Group.create! name: 'Checkers', description: 'yo', neighborhood_id: 2, kind: 2
  Group.create! name: 'Chess', description: 'yo', neighborhood_id: 3, kind: 0
  Group.create! name: 'Frisbee', description: 'yo', neighborhood_id: 3, kind: 1
  Group.create! name: 'Travel', description: 'yo', neighborhood_id: 3, kind: 2
  Group.create! name: 'Television', description: 'yo', neighborhood_id: 3, kind: 0
  Group.create! name: 'Ashby Village Announcements', description: 'yo', neighborhood_id: 2, kind: 1
end

def make_users
  User.create! first_name: 'Laila', last_name: 'Rowe', email: 'blah@gmail.com', phone: '917', cell_phone: '917', date_of_birth: 'date', password: 'okokokokok'
  User.create! first_name: 'Mark', last_name: 'Rowe', email: 'blah1@gmail.com', phone: '917', cell_phone: '917', date_of_birth: 'date', password: 'okokokokok'
  User.create! first_name: 'Jenny', last_name: 'Rowe', email: 'blah2@gmail.com', phone: '917', cell_phone: '917', date_of_birth: 'date', password: 'okokokokok'
  User.create! first_name: 'Sandra', last_name: 'Rowe', email: 'blah3@gmail.com', phone: '917', cell_phone: '917', date_of_birth: 'date', password: 'okokokokok'
  User.create! first_name: 'John', last_name: 'Rowe', email: 'blah4@gmail.com', phone: '917', cell_phone: '917', date_of_birth: 'date', password: 'okokokokok'
  User.create! first_name: 'Eric', last_name: 'Rowe', email: 'blah5@gmail.com', phone: '917', cell_phone: '917', date_of_birth: 'date', password: 'okokokokok'
  User.create! first_name: 'Dennis', last_name: 'Rowe', email: 'blah6@gmail.com', phone: '917', cell_phone: '917', date_of_birth: 'date', password: 'okokokokok'
  User.create! first_name: 'Ajay', last_name: 'Rowe', email: 'blah7@gmail.com', phone: '917', cell_phone: '917', date_of_birth: 'date', password: 'okokokokok'
end

def make_user_groups
  UserGroup.create! user_id: 1, group_id: 1, is_leader: true
  UserGroup.create! user_id: 1, group_id: 2, is_leader: true
  UserGroup.create! user_id: 1, group_id: 3, is_leader: true
  UserGroup.create! user_id: 1, group_id: 4, is_leader: false
  UserGroup.create! user_id: 1, group_id: 5, is_leader: false
  UserGroup.create! user_id: 1, group_id: 6, is_leader: false

  UserGroup.create! user_id: 2, group_id: 1, is_leader: false
  UserGroup.create! user_id: 3, group_id: 1, is_leader: false
  UserGroup.create! user_id: 4, group_id: 2, is_leader: true
  UserGroup.create! user_id: 5, group_id: 3, is_leader: true
  UserGroup.create! user_id: 6, group_id: 3, is_leader: false
  UserGroup.create! user_id: 7, group_id: 4, is_leader: true
  UserGroup.create! user_id: 8, group_id: 4, is_leader: false
  UserGroup.create! user_id: 9, group_id: 5, is_leader: true
end

def make_neighborhood
  Neighborhood.create! name: 'Kensington Kaleidoscope', description: '#'
  Neighborhood.create! name: 'Ashby Village', description: '#'
  Neighborhood.create! name: 'Outlandish', description: '#'
end

make_groups
make_users
make_user_groups
make_neighborhood
