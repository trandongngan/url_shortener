FactoryBot.define do
  factory :user do
    uid{ SecureRandom.uuid }

    after(:create) do |user|
      Oauth::GenerateTokenCommand.call(user_id: user.id)
    end
  end
end
