require_relative 'helper'

module RestoreBundledWith
  class TestLock < Test::Unit::TestCase
    sub_test_case '.insert' do
      test 'v1.9 lock file' do
        lock_file = File.read('./test/fixtures/v1-9-example1.lock')
        section = ''
        assert do
          Lock.insert(lock_file, section).to_s == lock_file
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
          Lock.insert(deleted, section).to_s == lock_file
        end
      end
    end

    sub_test_case '#delete_bundled_with' do
      test 'v1.9 lock file' do
        lock_file = File.read('./test/fixtures/v1-9-example1.lock')
        assert do
          Lock.new(lock_file).delete_bundled_with == Lock.new(lock_file)
        end
      end
      test 'v1.10 lock file' do
        lock_file = File.read('./test/fixtures/v1-10-example1.lock')
        deleted = File.read('./test/fixtures/v1-10-example1-deleted.lock')
        assert do
          Lock.new(lock_file).delete_bundled_with == Lock.new(deleted)
        end
      end
    end
  end
end
