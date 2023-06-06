# frozen_string_literal: true

class ForgetController < ApplicationController
  def index; end

  def forget_me
    current_user.destroy
  end
end
