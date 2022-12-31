# frozen_string_literal: true

class ShortLink < ApplicationRecord
  validates :original_url, presence: true, format: %r{http(s)://.+} # Simple check
  validate :over_a_hundred_link_per_day?, on: :create

  belongs_to :user

  COUNTER = 10_000_000_000
  REQUEST_LIMIT = 100

  def short_url
    return nil if id.nil?

    (COUNTER + id).to_base62_encode
  end

  class << self
    def find_by_short_url(short_url)
      find(short_url.to_base62_decode - COUNTER)
    end
  end

  private

  def over_a_hundred_link_per_day?
    return if user.short_links.where(created_at: Time.current.all_day).count < REQUEST_LIMIT

    errors.add(:base, "Only encode #{REQUEST_LIMIT} times in a day")
  end
end
