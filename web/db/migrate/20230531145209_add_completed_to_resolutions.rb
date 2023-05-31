# frozen_string_literal: true

class AddCompletedToResolutions < ActiveRecord::Migration[7.0]
  def change
    add_column :resolutions, :completed, :boolean
  end
end
