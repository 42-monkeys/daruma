# frozen_string_literal: true

class ForgetController < ApplicationController
  def index; end

  def forget_me
    debugger
    current_user.destroy
  end
end
