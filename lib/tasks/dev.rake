namespace :dev do

  desc "Setup Development"
    task setup: :environment do
      images_path = Rails.root.join('public', 'system')

      puts "Executando o setup para desenvolvimento..."

      puts "APAGANDO BD... #{%x(rake db:drop)}"
      puts "APAGANDO IMAGENS DE PUBLIC/SYSTEM... #{%x(rm -rf #{images_path})}"

      puts "CRIANDO BD... #{%x(rake db:create)}"
      puts %x(rake db:migrate)
      puts %x(rake db:seed)
      puts %x(rake dev:generate_admins)
      puts %x(rake dev:generate_members)
      puts %x(rake dev:generate_ads)
      puts %x(rake dev:generate_comments)

      puts "Setup completado com sucesso!"
    end


  desc "Cria Administradores Fake"
  task generate_admins: :environment do

    puts "Criando administradores"

    10.times do
      Admin.create!(
              name: Faker::Name.name,
              email: Faker::Internet.email,
              password: "123456",
              password_confirmation: "123456",
              role: [0, 1, 1, 1 ,1].sample
             )
    end

    puts "Administradores cadastrados com sucesso"
  end

  desc "Cria Membros Fake"
  task generate_members: :environment do

    puts "Criando Membros Fake"

    100.times do
      member = Member.new(
              email: Faker::Internet.email,
              password: "123456",
              password_confirmation: "123456"
             )
      member.build_profile_member

      member.profile_member.first_name = Faker::Name.first_name
      member.profile_member.second_name = Faker::Name.last_name

      member.save!
    end

    puts "Membros cadastrados com sucesso"
  end

  desc "Cria Anuncios Fake"
  task generate_ads: :environment do

    puts "Criando anuncios"

    100.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description_md: markdown_fake,
        description_short: Faker::Lorem.sentence([2,3].sample),
        member: Member.all.sample,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        finish_date: Date.today + Random.rand(90),
        picture: File.new(Rails.root.join('public', 'templates', 'images-for-ads', "#{Random.rand(9)}.jpeg"), 'r')
      )
    end

    5.times do
      Ad.create!(
        title: Faker::Lorem.sentence([2,3,4,5].sample),
        description_md: markdown_fake,
        description_short: Faker::Lorem.sentence([2,3].sample),
        member: Member.first,
        category: Category.all.sample,
        price: "#{Random.rand(500)},#{Random.rand(99)}",
        finish_date: Date.today + Random.rand(90),
        picture: File.new(Rails.root.join('public', 'templates', 'images-for-ads', "#{Random.rand(9)}.jpeg"), 'r')
      )
    end

    puts "Anuncios cadastrados com sucesso"
  end

  def markdown_fake
    %x(ruby -e "require 'doctor_ipsum'; puts DoctorIpsum::Markdown.entry")
  end
 ###################################################

 desc "Cria Comentarios Fake"
 task generate_comments: :environment do

   puts "Criando Comentarios Fake"

   Ad.all.each do |ad|
     (Random.rand(3)).times do
       Comment.create!(
         body: Faker::Lorem.paragraph([1,2,3].sample),
         member: Member.all.sample,
         ad: ad
       )
     end
   end
   puts "Comentarios cadastrados com sucesso"
 end
end
