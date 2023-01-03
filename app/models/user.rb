# frozen_string_literal: true

class User < ApplicationRecord
  has_many :access_tokens,
           class_name: "Doorkeeper::AccessToken",
           foreign_key: :resource_owner_id,
           inverse_of: false,
           dependent: :delete_all

  has_many :short_links, dependent: :delete_all
end
