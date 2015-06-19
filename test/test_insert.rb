require_relative 'helper'

module RestoreBundledWith
  class TestInsert < Test::Unit::TestCase
    sub_test_case '.insert' do
      test 'v1.9 lock file' do
        lock_file = File.read('./test/fixtures/v1-9-example1.lock')
        section = ''
        assert do
          Insert.new(lock_file, section).insert == lock_file
        end
      end
      test 'v1.10 lock file' do
        deleted = File.read('./test/fixtures/v1-10-example1-deleted.lock')
        # FIXME: rstrip ?
        section = File
                  .read('./test/fixtures/v1-10-example1-block.txt')
                  .rstrip
        lock_file = File.read('./test/fixtures/v1-10-example1.lock')
        assert do
          Insert.new(deleted, section).insert == lock_file
        end
      end
    end
  end
end
