# frozen_string_literal: true

class AddTemperToReminder < ActiveRecord::Migration[7.0]
  def change
    add_column :reminders, :temper, :integer
  end
end
