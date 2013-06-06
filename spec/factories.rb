FactoryGirl.define do
  factory :post do
    title 'factory title'
  end
  
  factory :section do
    content 'factory content'
  end

  factory :tag do
    sequence(:name){|n| "factory name #{n}"}
  end

  factory :user do
    email 'test@example.com'
    password 'foobar'
    username 'tester'
  end
end
