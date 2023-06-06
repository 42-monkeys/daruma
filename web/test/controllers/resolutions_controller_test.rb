# frozen_string_literal: true

require 'test_helper'

class ResolutionsControllerTest < ActionDispatch::IntegrationTest
  class Authorized < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers
    setup do
      @resolution = resolutions(:one)
      @user = users(:one)
      @user.confirm
      sign_in @user
    end

    test 'should get index' do
      get resolutions_url
      assert_response :success
    end

    test 'should get new' do
      get new_resolution_url
      assert_response :success
    end

    test 'should set completed' do
      get resolution_complete_url(resolution_id: @resolution.id, completed: 'true')
      assert_redirected_to resolution_url(@resolution)
    end

    test 'should set not completed' do
      get resolution_complete_url(resolution_id: @resolution.id, completed: 'false')
      assert_redirected_to resolution_url(@resolution)
    end

    test 'should create resolution' do
      assert_difference('Resolution.count') do
        post resolutions_url, params: { resolution: {
          body: 'hahahah',
          commitment: 'high',
          time_limit: Date.new + 1.week,
          temper: 'authoritarian',
          user: :one
        } }
      end

      assert_redirected_to resolution_url(Resolution.last)
    end

    test 'should show resolution' do
      get resolution_url(@resolution)
      assert_response :success
    end
  end

  class Unauthorized < ActionDispatch::IntegrationTest
    setup do
      @resolution = resolutions(:one)
    end

    test 'shouldn\'t get index' do
      get resolutions_url
      assert_response :redirect
    end

    test 'shouldn\'t get new' do
      get new_resolution_url
      assert_response :redirect
    end

    test 'shouldn\'t create resolution' do
      post resolutions_url, params: { resolution: {
        body: 'trololol',
        commitment: 'high',
        time_limit: Date.new + 1.week,
        temper: 'authoritarian',
        user: :one
      } }

      assert_response :redirect
    end

    test 'shouldn\'t set completed' do
      get resolution_complete_url(resolution_id: @resolution.id, completed: 'true')
      assert_response :redirect
    end

    test 'shouldn\'t set not completed' do
      get resolution_complete_url(resolution_id: @resolution.id, completed: 'false')
      assert_response :redirect
    end

    test 'shouldn\'t show resolution' do
      get resolution_url(@resolution)
      assert_response :redirect
    end
  end
end
