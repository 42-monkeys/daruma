# frozen_string_literal: true

class CreateResolutions < ActiveRecord::Migration[7.0]
  def change
    create_table :resolutions do |t|
      t.text :body

      t.timestamps
    end
  end
end
