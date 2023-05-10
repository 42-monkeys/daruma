# frozen_string_literal: true

class StatsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @stats = {}
    @stats[:total_spent] = Resolution.all.map(&:cost).sum # TODO: optimize :/
    @stats[:total_offers] = Resolution.sum(:offer)
  end
end
