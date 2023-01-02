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

    def render400(excepttion)
      handle_error_response(excepttion, status: :bad_request)
    end

    def render404(excepttion)
      handle_error_response(excepttion, status: :not_found)
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
