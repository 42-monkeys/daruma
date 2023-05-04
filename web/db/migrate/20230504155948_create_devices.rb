# frozen_string_literal: true

class CreateDevices < ActiveRecord::Migration[7.0]
  def change
    create_table :devices do |t|
      t.references :user, index: true, foreign_key: true
      t.string :token
      t.string :platform
      t.timestamps
    end
  end
end
