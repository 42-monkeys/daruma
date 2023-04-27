# frozen_string_literal: true

class Resolution < ApplicationRecord
  validates :body, presence: true
  validates :commitment, presence: true
  validates :target_time, presence: true
  validates :temper, presence: true

  has_rich_text :body

  enum :commitment_types, [ :low, :moderate, :high ]
  enum :temper_types, [ :motivational, :sarcastic, :authoritarian, :random ]
  # colori daruma

  # motivational    dorato
  # sarcastic       verde
  # authoritarian   nero
  # random          rosso

  belongs_to :user
end
