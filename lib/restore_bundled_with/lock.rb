module RestoreBundledWith
  # The lock file
  class Lock < RestoreFromRepository::TargetFile
    REGEX_BUNDLED_WITH = /^(?<pick>(?:\r\n|\r|\n)^BUNDLED WITH.*(?:\r\n|\r|\n).+(?:\r\n|\r|\n))/
    FILE_NAME = 'Gemfile.lock'.freeze

    # @param text [String] base lock file
    # @param section [String] appending section
    #
    # @return [Lock] the lock file instance
    def self.insert(text, section)
      if section && !section.empty?
        new(text + section)
      else
        new(text)
      end
    end

    # @param data [String] before restore
    # @param lockfile [String] file name
    # @param ref [String] git ref
    # @param git_path [String] git repository path
    # @param git_options [Hash] ruby-git options
    # @param new_line [String] new line
    # @param pattern [Regexp] match pattern
    #
    # @return [Lock] the lock file instance
    def self.restore(
      data,
      lockfile = FILE_NAME,
      ref = Repository::REF,
      git_path = Repository::GIT_PATH,
      git_options = Repository::GIT_OPTIONS,
      new_line = Repository::NEW_LINE,
      pattern = REGEX_BUNDLED_WITH
    )
      super(data, lockfile, pattern, ref, git_path, git_options, new_line)
    end

    # @example delete bundled with
    #   "\n\nBUNDLED WITH\n   1.10.4\n" => "\n"
    #
    # @return [Lock] new lock file instance which is deleted bundled with
    def delete_bundled_with
      delete_by_pattern(REGEX_BUNDLED_WITH)
    end

    # @return [String] pick target section
    def pick
      pick_by_pattern(REGEX_BUNDLED_WITH)
    end
  end
end
