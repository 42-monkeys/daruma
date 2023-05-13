# frozen_string_literal: true

class DevicesController < ApplicationController
  def create
    @device = Device.find_or_initialize_by(user: current_user.id, token: device_params[:token],
                                           platform: device_params[:platform])

    respond_to do |format|
      if @device.save
        format.json { render :show, status: :created, location: @device }
      else
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def device_params
    params.require(:device).permit(:token, :platform)
  end
end
