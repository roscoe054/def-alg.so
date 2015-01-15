FactoryGirl.define do
  factory :user do
    email "test@email.com"
    name "test_name"
    password "test_password"
    password_confirmation "test_password"
  end

end