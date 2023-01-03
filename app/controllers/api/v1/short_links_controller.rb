# frozen_string_literal: true

class Api::V1::ShortLinksController < Api::V1::BaseController
  def decode
    short_link = current_user.short_links.find_by_short_url(params.fetch(:short_url).gsub(base_url, "")) # rubocop:disable Rails/DynamicFindBy

    render json: {original_url: short_link.original_url}
  end

  def encode
    short_link = current_user.short_links.first_or_create!(original_url: params.fetch(:url))

    render json: {short_url: base_url + short_link.short_url}
  end

  private

  def base_url
    ENV["BASE_URL"] || "localhost:3000/"
  end
end
