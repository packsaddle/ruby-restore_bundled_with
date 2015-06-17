require_relative 'helper'

module RestoreBundledWith
  class TestRestore < Test::Unit::TestCase
    test 'version' do
      assert do
        !::RestoreBundledWith::VERSION.nil?
      end
    end
  end
end
