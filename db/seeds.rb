# db/seeds.rb

admin_email = ENV.fetch('ADMIN_EMAIL', 'admin@example.com')
admin_password = ENV.fetch('ADMIN_PASSWORD', 'securepassword')

admin = User.find_or_initialize_by(email: admin_email)
admin.name = "Admin"
admin.password = securepassword
admin.password_confirmation = securepassword
admin.role = "admin" # ensure you have a `role` column or `enum role: { admin: 0, user: 1 }` in User model
admin.save!

puts "✅ Admin user seeded: #{admin.email}"
