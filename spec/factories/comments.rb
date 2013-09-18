# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    text "Comment text"
    rating 1
    association :post, factory: :post
    association :user, factory: :user
  end
end
