# frozen_string_literal: true

class AddTimingToResolutions < ActiveRecord::Migration[7.0]
  def change
    add_column :resolutions, :time_limit, :date
    add_column :resolutions, :commitment, :integer
  end
end
