require_relative 'helper'

module RestoreBundledWith
  class TestLock < Test::Unit::TestCase
    sub_test_case '.insert' do
      test 'v1.9 lock file' do
        lock_file = File.read('./test/fixtures/v1-9-example1.lock')
        section = ''
        assert do
          Lock.insert(lock_file, section) == Lock.new(lock_file)
        end
      end
      test 'v1.10 lock file' do
        deleted = File.read('./test/fixtures/v1-10-example1-deleted.lock')
        section = File.read('./test/fixtures/v1-10-example1-block.txt')
        lock_file = File.read('./test/fixtures/v1-10-example1.lock')
        assert do
          Lock.insert(deleted, section) == Lock.new(lock_file)
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

    sub_test_case '#pick' do
      test 'v1.9 lock file' do
        lock_file_contents = File.read('./test/fixtures/v1-9-example1.lock')
        expected = ''
        assert do
          Lock.new(lock_file_contents).pick == expected
        end
      end
      test 'v1.10 lock file' do
        lock_file_contents = File.read('./test/fixtures/v1-10-example1.lock')
        expected = File.read('./test/fixtures/v1-10-example1-block.txt')
        assert do
          Lock.new(lock_file_contents).pick == expected
        end
      end
    end

    sub_test_case '#==' do
      test 'compare different lock file' do
        v19 = File.read('./test/fixtures/v1-9-example1.lock')
        v110 = File.read('./test/fixtures/v1-10-example1.lock')
        assert do
          Lock.new(v19) != Lock.new(v110)
        end
      end
      test 'compare same lock file' do
        v110 = File.read('./test/fixtures/v1-10-example1.lock')
        one = Lock.new(v110)
        other = Lock.new(v110)
        assert do
          one == other
        end
      end
    end
  end
end
