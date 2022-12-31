class CreateShortLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :short_links do |t|
      t.string :original_url
      t.bigint :user_id

      t.timestamps
    end
  end
end
