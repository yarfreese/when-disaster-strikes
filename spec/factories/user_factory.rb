FactoryGirl.define do
  factory :user do
    name "fred"
    email "fred@example.com"
    password "password"
    password_confirmation "password"
  end
end
