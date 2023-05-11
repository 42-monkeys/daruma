# frozen_string_literal: true

class RemindersController < ApplicationController
  def index
    @reminders = Resolution.find_by(id: params[:resolution_id], user: current_user).reminders
  end
end
