# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Cadastrando as categorias"

categories = ["Animais e acessórios",
"Esportes",
"Para a sua casa",
"Eletrônicos e celulares",
"Música e hobbies",
"Bebês e crianças",
"Moda e beleza",
"Veículos e barcos",
"Imóveis",
"Empregos e negócios"]

categories.each do |category|
  Category.friendly.find_or_create_by(description: category)
end

puts "Categorias cadastradas com sucesso"

####################

puts "Cadastrando o Administrador padrão..."

Admin.create!(name: "Administrador Geral", email: "admin@admin.com", password: "123456", password_confirmation: "123456", role: 0)

puts "Administrador padrão cadastrado com sucesso"


puts "Cadastrando o Membro padrão..."

member = Member.new(email: "membro@membro.com", password: "123456", password_confirmation: "123456")

member.build_profile_member

member.profile_member.first_name = Faker::Name.first_name
member.profile_member.second_name = Faker::Name.last_name

member.save!

puts "Membro padrão cadastrado com sucesso"
