
Factory.define :user do |user|
  user.name        "John Doe"
  user.email       "jdoe@example.com"
end


Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :micropost do |micropost|
  micropost.content "This is a test post"
  micropost.association :user
end
