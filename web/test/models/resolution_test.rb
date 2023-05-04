# frozen_string_literal: true

require 'test_helper'

class ResolutionTest < ActiveSupport::TestCase
  setup do
    @resolution = resolutions(:one)
  end

  test 'it generate reminders' do
    @resolution.generate_reminder

    reminder = @resolution.reminders.first
    assert_equal(reminder.body, 'some generated text')
    assert(reminder.sent)
  end

  test 'it starts with no memory' do
    prompt = @resolution.prompt

    assert_not(prompt.include?('must be different from these previous sentences, enclosed in double backticks'))
  end

  test 'it continues with memory' do
    resolution = resolutions(:two)

    prompt = resolution.prompt

    assert(prompt.include?('must be different from these previous sentences, enclosed in double backticks'))
  end

  test 'it gets temper if not random' do
    temper = @resolution.temper_for_request

    assert(temper, @resolution.temper)
  end

  test 'it gets random temper if have to do it' do
    @resolution.temper = :random

    temper = @resolution.temper_for_request

    assert(temper, :random)
  end
end
