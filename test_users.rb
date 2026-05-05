# Verificar usuarios y crear uno de prueba
ENV['PGUSER'] = 'postgres'
ENV['PGPASSWORD'] = 'postgres'

require_relative 'config/environment'

puts "Cantidad de usuarios: #{User.count}"

if User.count > 0
  u = User.first
  puts "Email: #{u.email_address}"
  puts "Password digest (encriptado): #{u.password_digest[0..60]}..."
else
  puts "No hay usuarios. Creando uno de prueba..."
  u = User.create!(email_address: 'test@example.com', password: 'password123')
  puts "Usuario creado: #{u.email_address}"
  puts "Password digest (encriptado): #{u.password_digest[0..60]}..."
end