# frozen_string_literal: true

class ResolutionsController < ApplicationController
  def index
    @resolutions = Resolution.where(user: current_user)
  end

  def show
    @resolution = Resolution.find_by(id: params[:id], user: current_user)
  end

  def new
    @resolution = Resolution.new
  end

  def complete
    @resolution = Resolution.find_by(id: params[:resolution_id], user: current_user)
    @resolution.completed = params[:completed]
    respond_to do |format|
      if @resolution.save
        format.html { redirect_to resolution_url(@resolution), notice: 'Resolution was successfully completed!' }
        format.json { render :show, status: :success, location: @resolution }
      else
        format.html { render :show, status: :unprocessable_entity }
        format.json { render json: @resolution.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @resolution = Resolution.new(resolution_params)
    @resolution.user = current_user

    respond_to do |format|
      if @resolution.save
        format.html { redirect_to resolution_url(@resolution), notice: 'Resolution was successfully created.' }
        format.json { render :show, status: :created, location: @resolution }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @resolution.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def resolution_params
    params.require(:resolution).permit(:body, :time_limit, :commitment, :temper, :offer)
  end
end
