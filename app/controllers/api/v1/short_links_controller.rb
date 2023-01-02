# frozen_string_literal: true

class Api::V1::ShortLinksController < Api::V1::BaseController
  def decode
    short_link = ShortLink.find_by_short_url(params.fetch(:short_url)) # rubocop:disable Rails/DynamicFindBy

    render json: short_link, type: :decode
  end

  def encode
    short_link = ShortLink.create!(original_url: params.fetch(:url))

    render json: short_link
  end
end
