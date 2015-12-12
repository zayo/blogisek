# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

admin = User.create!([
                       {
                         email:                  "admin@admin.com",
                         password:               "adminadmin",
                       }
                     ])
admin.update!({
               reset_password_token:   nil,
               reset_password_sent_at: nil,
               remember_created_at:    nil,
               sign_in_count:          1,
               current_sign_in_at:     "2015-12-12 17:20:29",
               last_sign_in_at:        "2015-12-12 17:20:29",
               current_sign_in_ip:     "::1",
               last_sign_in_ip:        "::1",
               confirmation_token:     "HdJf6NxaeyJACXieAqxs",
               confirmed_at:           "2015-12-12 17:19:17",
               confirmation_sent_at:   "2015-12-12 17:17:30",
               unconfirmed_email:      nil,
               avatar_file_name:       nil,
               avatar_content_type:    nil,
               avatar_file_size:       nil,
               avatar_updated_at:      nil
             })
admin.add_role :admin

=begin
User.first_or_create([{ email: 'kokot1@velky.com', password: 'kokotiny' },{ email: 'kokot2@velky.com', password: 'kokotiny' }])
Post.create({ user_id: user1.id, title: 'Nazev1', description: 'simple test of post' })
Post.create({ user_id: user2.id, title: 'Nazev2', description: 'simple test of post' })
=end


