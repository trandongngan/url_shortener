# frozen_string_literal: true

class Api::V1::ApiDocsController < ApplicationController
  def index
    render json: Swagger::Definition.call
  end
end
