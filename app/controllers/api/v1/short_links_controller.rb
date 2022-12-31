# frozen_string_literal: true

class Api::V1::ShortLinksController < Api::V1::BaseController
  def decode
    short_link = ShortLink.find_by(short_url: params.fetch(:short_url))

    render json: short_link, with_type: :decode
  end

  def encode
    short_link = ShortLink.create!(original_url: params.fetch(:url))

    render json: short_link, with_type: :encode
  end
end
