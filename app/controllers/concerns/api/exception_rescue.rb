# frozen_string_literal: true

module Api::ExceptionRescue
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::ParameterMissing, with: :render400
    rescue_from ActiveRecord::RecordInvalid, with: :render422
    rescue_from ActiveRecord::RecordNotFound, with: :render404

    # TODO
    # Need handle 401, 403, 500, 502, 503 ...
    # rescue_from Exception, with: :render500 unless Rails.env.development?

    def render400
      render json: {erorr_message: "Bad request"}, status: :bad_request
    end

    def render404
      render json: {erorr_message: "Resource not found"}, status: :not_found
    end

    def render422(exception)
      render json: {erorr_message: exception.record.errors.full_messages}, status: :unprocessable_entity
    end
  end
end
