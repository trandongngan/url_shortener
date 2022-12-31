# frozen_string_literal: true

class Rack::StripXForwardedHost
  def initialize(app)
    @app = app
  end

  def call(env)
    env.delete("HTTP_X_FORWARDED_HOST")
    @app.call(env)
  end
end
