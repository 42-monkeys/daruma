# frozen_string_literal: true

class DevicesController < ApplicationController
  def create
    @device = Device.find_by(user: current_user)

    @device = Device.new(user: current_user) if @device.blank?
    @device.token = device_params[:token]
    @device.platform = device_params[:platform]

    respond_to do |format|
      if @device.save
        format.json { render json: @device, status: :created }
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
