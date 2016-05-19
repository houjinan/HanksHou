require 'faker'
FactoryGirl.define do
  # sequence :user_email do |n|
  #   "aa#{n}@example.com"
  # end

  factory :user, aliases: [:email_confirmed_user, :last_user] do
    # email { generate(:user_email) }
    email { Faker::Internet.email }
    # email "user#{User.count}@test.com"
    password "88888888"

    factory :user_with_articles do
      transient do
        articles_count 5 
      end

      after(:create) do |user, evaluator|
        create_list(:article, evaluator.articles_count, user: user)
      end
    end 
  end



end