require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
    make_microposts
    
  end
end

def make_users
  admin = User.create!(:nom => "Example User",
                       :email => "example@railstutorial.org",
                       :password => "foobar",
                       :password_confirmation => "foobar")
  admin.toggle!(:admin)
  99.times do |n|
    nom = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(:nom => nom,
                 :email => email,
                 :password => password,
                 :password_confirmation => password)
  end
end

def make_microposts
  50.times do
    User.all(:limit => 6).each do |user|
      user.microposts.create!(:content => Faker::Lorem.sentence(5))
    end
  end
end


