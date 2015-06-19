require_relative 'helper'

module RestoreBundledWith
  class TestDelete < Test::Unit::TestCase
    sub_test_case '.delete' do
      test 'v1.9 lock file' do
        lock_file = File.read('./test/fixtures/v1-9-example1.lock')
        assert do
          Delete.new(lock_file).delete == lock_file
        end
      end
      test 'v1.10 lock file' do
        lock_file = File.read('./test/fixtures/v1-10-example1.lock')
        deleted = File.read('./test/fixtures/v1-10-example1-deleted.lock')
        assert do
          Delete.new(lock_file).delete == deleted
        end
      end
    end
  end
end
