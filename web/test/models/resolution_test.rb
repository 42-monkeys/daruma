# frozen_string_literal: true

require 'test_helper'

class ResolutionTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  setup do
    @resolution = resolutions(:one)
  end

  test 'it generate reminders' do
    @resolution.generate_reminder

    assert_enqueued_with(job: SendRemindersJob, args: [@resolution.reminders.first])
  end

  test 'it dosn\'t generate double reminders' do
    @resolution.generate_reminder

    @resolution.generate_reminder

    assert_equal(1, @resolution.reminders.count)
  end

  test 'it dosn\'t generate reminders for elasped resolutions' do
    resolution = resolutions(:elapsed)

    resolution.generate_reminder

    assert_equal(0, resolution.reminders.count)
  end

  test 'it dosn\'t generate reminders with low commitment and already sent reminder in period' do
    resolution = resolutions(:with_reminder)

    resolution.generate_reminder

    assert_equal(1, resolution.reminders.count)
  end

  test 'it starts with no memory' do
    prompt = @resolution.prompt

    assert_not(prompt.include?('must be different from these previous sentences, enclosed in double backticks'))
  end

  test 'it continues with memory' do
    resolution = resolutions(:with_reminder)

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
