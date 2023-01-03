FactoryBot.define do
  factory :short_link do
    user

    original_url{ " https://codesubmit.io/library/react" }
  end
end
