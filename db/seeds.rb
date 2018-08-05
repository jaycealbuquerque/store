# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "cadastrando as categorias...."
categories = ["animail",
                "esporte",
                "casa",
                "eletronico",
                "moda",
                "imaveis"]


categories.each do |category|
    Category.find_or_create_by(description: category)
end

puts "categorias cadastradas"

###################

puts "Cadastrando o ADMINISTRADOR Padrão..."

Admin.create!(
	name: "Administrador Geral",
	email: "jeyce@jeyce.com",
    password: "123456",
    password_confirmation: "123456",
    role: 0)
	

puts "ADMINISTRADOR cadastrado com sucesso!"