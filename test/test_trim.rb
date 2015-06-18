require_relative 'helper'

module RestoreBundledWith
  class TestTrim < Test::Unit::TestCase
    sub_test_case '.trim' do
      test 'v1.9 lock file' do
        actual_lock_file = File.read('./test/fixtures/v1-9-example1.lock')
        assert do
          Trim.new(actual_lock_file).trim == actual_lock_file
        end
      end
      test 'v1.10 lock file' do
        actual_lock_file = File.read('./test/fixtures/v1-10-example1.lock')
        expected_trimmed_lock_file = File.read('./test/fixtures/v1-10-example1-trimmed.lock')
        assert do
          Trim.new(actual_lock_file).trim == expected_trimmed_lock_file
        end
      end
    end
  end
end
