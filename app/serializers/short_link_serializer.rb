# frozen_string_literal: true

class ShortLinkSerializer < ActiveModel::Serializer
  def attributes(*_agrs)
    unless decode?
      base_url = ENV["BASE_URL"] || "localhost:3000"

      return {short_url: [base_url, object.short_url].join("/")}
    end

    {original_url: object.original_url}
  end

  private

  def decode?
    @instance_options[:type]&.to_sym == :decode
  end
end
