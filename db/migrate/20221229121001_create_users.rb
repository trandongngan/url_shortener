# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      # t.string   :email
      t.string   :uid

      # t.datetime :last_sign_in_at
      t.datetime :current_sign_in_at
      # t.string   :last_sign_in_ip
      t.string   :current_sign_in_ip

      t.timestamps null: false
    end
  end
end
