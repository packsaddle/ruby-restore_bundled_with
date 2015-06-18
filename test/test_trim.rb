require_relative 'helper'

module RestoreBundledWith
  class TestTrim < Test::Unit::TestCase
    sub_test_case '.trim' do
      test 'v1.9 lock file' do
        lock_file = File.read('./test/fixtures/v1-9-example1.lock')
        assert do
          Trim.new(lock_file).trim == lock_file
        end
      end
      test 'v1.10 lock file' do
        lock_file = File.read('./test/fixtures/v1-10-example1.lock')
        trimmed = File.read('./test/fixtures/v1-10-example1-trimmed.lock')
        assert do
          Trim.new(lock_file).trim == trimmed
        end
      end
    end
  end
end
