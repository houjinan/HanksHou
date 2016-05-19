FactoryGirl.define do
  factory :article, class: Article do
    title "MyString"
    content "MyString"
    visit_count 1 
  end
end