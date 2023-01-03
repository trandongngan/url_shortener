# frozen_string_literal: true

namespace :once_time do
  desc "Once time task"
  task user_first: :environment do
    user = User.first
    user = User.create!(uid: SecureRandom.uuid) if user.nil?

    if user.access_tokens.blank?
      Oauth::GenerateTokenCommand.call(user_id: user.id)
      user.reload
    end

    puts user.access_tokens.first.token
  end
end
