# db/seeds.rb

admin_email = ENV.fetch('ADMIN_EMAIL', 'admin@example.com')
admin_password = ENV.fetch('ADMIN_PASSWORD', 'securepassword')

admin = User.find_or_initialize_by(email: admin_email)
admin.password = admin_password
admin.password_confirmation = admin_password
admin.role = "admin" # Ensure you have `role` column (you do)

if admin.save
  puts "✅ Admin user seeded: #{admin.email}"
else
  puts "❌ Failed to seed admin user: #{admin.errors.full_messages.join(', ')}"
end
