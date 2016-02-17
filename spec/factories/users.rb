FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    name { Faker::Name.first_name }
    password "password"
    password_confirmation "password"
    factory :user_with_images do
      transient do
          images_count 5
        end
      after(:create) do |user, evaluator|
          create_list(:image, evaluator.images_count, user: user)
      end
    end
  end
end
