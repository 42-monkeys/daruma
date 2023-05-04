# frozen_string_literal: true

class AddTokensToReminders < ActiveRecord::Migration[7.0]
  def change
    add_column :reminders, :prompt_tokens, :integer
    add_column :reminders, :completion_tokens, :integer
  end
end
