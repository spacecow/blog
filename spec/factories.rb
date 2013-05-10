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
end
