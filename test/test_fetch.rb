require_relative 'helper'

module RestoreBundledWith
  class TestFetch < Test::Unit::TestCase
    sub_test_case '.pick' do
      test 'v1.9 lock file' do
        lock_file_path = 'Gemfile.lock'
        ref = 'HEAD'
        # FIXME: rstrip ?
        lock_file_contents = File
                             .read('./test/fixtures/v1-9-example1.lock')
                             .rstrip
        fetch = Fetch.new(lock_file_path, ref)
        stub(fetch).target_file_contents { lock_file_contents }
        expected = ''
        assert do
          fetch.pick == expected
        end
      end
      test 'v1.10 lock file' do
        lock_file_path = 'Gemfile.lock'
        ref = 'HEAD'
        # FIXME: rstrip ?
        lock_file_contents = File
                             .read('./test/fixtures/v1-10-example1.lock')
                             .rstrip
        fetch = Fetch.new(lock_file_path, ref)
        stub(fetch).target_file_contents { lock_file_contents }
        # FIXME: rstrip ?
        expected = File
                   .read('./test/fixtures/v1-10-example1-block.txt')
                   .rstrip
        assert do
          fetch.pick == expected
        end
      end
    end
  end
end
