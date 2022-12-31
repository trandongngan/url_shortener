# frozen_string_literal: true

class Api::V1::BaseController < ApplicationController
  before_action :authorize_user!
  before_action :trackable

  include Api::ExceptionRescue

  private

  def current_user
    @current_user ||= User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def trackable
    return if current_user.nil?

    current_user.update(current_sign_in_at: Time.current, current_sign_in_ip: request.remote_ip)
  end

  def authorize_user!
    doorkeeper_authorize!("user")
  end

  def doorkeeper_unauthorized_render_options(_error = nil)
    {json: {erorr_message: "Unauthorized"}}
  end

  def doorkeeper_forbidden_render_options(_error = nil)
    {json: {erorr_message: "Forbidden"}}
  end
end
