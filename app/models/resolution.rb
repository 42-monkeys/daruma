# frozen_string_literal: true

class Resolution < ApplicationRecord
  validates :body, presence: true
  has_rich_text :body

  belongs_to :user
end
