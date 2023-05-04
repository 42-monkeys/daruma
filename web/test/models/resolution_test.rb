# frozen_string_literal: true

require 'test_helper'

class ResolutionTest < ActiveSupport::TestCase
  setup do
    @resolution = resolutions(:one)
  end

  test 'it generate reminders' do
    @resolution.generate_reminder

    reminder = @resolution.reminders.first
    assert_equal(reminder.body, 'reminder text')
    assert(reminder.sent)
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
