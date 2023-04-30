# frozen_string_literal: true

class Resolution < ApplicationRecord
  validates :body, presence: true
  validates :commitment, presence: true
  validates :target_time, presence: true
  validates :temper, presence: true
  validates :offer, numericality: { only_numeric: true } # TODO: positive ;)

  has_rich_text :body

  enum :commitment_types, %i[low moderate high]
  enum :temper_types, %i[motivational sarcastic authoritarian random]

  belongs_to :user
end
