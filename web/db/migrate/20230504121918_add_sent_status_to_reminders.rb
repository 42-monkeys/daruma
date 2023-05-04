# frozen_string_literal: true

class AddSentStatusToReminders < ActiveRecord::Migration[7.0]
  def change
    add_column :reminders, :sent, :boolean
  end
end
