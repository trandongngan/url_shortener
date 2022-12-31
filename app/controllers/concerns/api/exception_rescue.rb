# frozen_string_literal: true

module Api::ExceptionRescue
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::ParameterMissing, with: :render400
    rescue_from ActiveRecord::RecordInvalid, with: :render422
    rescue_from Api::Errors::Unauthorized, Api::Errors::InvalidToken, with: :render401
    rescue_from ActiveRecord::RecordNotFound, with: :render404

    # TODO
    # Need handle 403, 500, 502, 503 ...
    # rescue_from Exception, with: :render_500 unless Rails.env.development?

    def render400(excepttion)
      handle_error_response(excepttion, status: :bad_request)
    end

    def render401(excepttion)
      handle_error_response(excepttion, status: :unauthorized)
    end

    def render404(_excepttion)
      handle_error_response(ex, status: :not_found)
    end

    def render422(excepttion)
      handle_error_response(excepttion, status: :unprocessable_entity)
    end

    private

    def handle_error_response(excepttion, status:)
      # TODO: Notify to somewhere that we can monitor error (Rollbar ...)
      # Rollbar level: critical, error, warning, info, debug
      # notify.send(level, ex, {})

      render json: excepttion.as_json, status: status
    end
  end
end
