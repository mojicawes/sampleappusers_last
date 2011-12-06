require 'faker'

namespace :db do
    desc "Populate database with sample data"
    task :populate => :environment do
      Rake::Task['db:reset'].invoke
         make_users
         make_microposts
         make_groups
    end
    
    def make_users   
      User.create!(:name => "John Doe",
                   :email => "jdoe@cs.utsa.edu")
          
      99.times do |n|
        name = Faker::Name.name
        email = "name-#{n+1}@cs.utsa.edu"
        User.create!(:name => name,
                     :email => email)    
      end
    end
    
    def make_microposts
      User.all(:limit => 5).each do |user|
        50.times do
          content = Faker::Lorem.sentence(5)
          user.microposts.create!(:content => content)
        end
      end
    end
    
    def make_groups
      users = User.all
      user = users.first
      following = users[1..50]
      followers = users[5..20]
      following.each { 
        |leader| user.follow!(leader)
      }
      followers.each {
        |follower| follower.follow!(user)
      }
    end
end
