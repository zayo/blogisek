# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create!([{ email: "admin@admin.com", password: "adminadmin" }])
admin.update!({ reset_password_token: nil, unconfirmed_email: nil })
admin.add_role :admin

=begin
User.first_or_create([{ email: 'kokot1@velky.com', password: 'kokotiny' },{ email: 'kokot2@velky.com', password: 'kokotiny' }])
Post.create({ user_id: user1.id, title: 'Nazev1', description: 'simple test of post' })
Post.create({ user_id: user2.id, title: 'Nazev2', description: 'simple test of post' })
=end


