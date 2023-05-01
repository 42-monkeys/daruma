# frozen_string_literal: true

class Resolution < ApplicationRecord
  validates :body, presence: true
  validates :commitment, presence: true
  validates :time_limit, presence: true
  validates :temper, presence: true
  validates :offer, allow_blank: true, numericality: { only_numeric: true } # TODO: positive ;)

  enum :commitment_types, %i[low moderate high]
  enum :temper_types, %i[motivational sarcastic authoritarian random]

  belongs_to :user
end
