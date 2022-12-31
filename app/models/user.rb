# frozen_string_literal: true

class User < ApplicationRecord
  has_many :short_links, dependent: :destroy
end
