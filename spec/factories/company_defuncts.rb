# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company_defunct do
    company nil
    day 1
    month 1
    year 1
    additional_info "MyString"
  end
end
