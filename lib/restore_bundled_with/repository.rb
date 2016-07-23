module RestoreBundledWith
  class Repository < ::RestoreFromRepository::Repository
    LOCK_FILE = 'Gemfile.lock'
  end
end
