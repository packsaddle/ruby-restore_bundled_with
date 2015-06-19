require_relative 'helper'

module RestoreBundledWith
  class TestInsert < Test::Unit::TestCase
    sub_test_case '.insert' do
      test 'format' do
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
