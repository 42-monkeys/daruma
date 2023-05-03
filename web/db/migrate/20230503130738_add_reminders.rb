# frozen_string_literal: true

class AddReminders < ActiveRecord::Migration[7.0]
  def change
    create_table :reminders do |t|
      t.text :body
      t.references :resolution, null: false, foreign_key: true

      t.timestamps
    end
  end
end
