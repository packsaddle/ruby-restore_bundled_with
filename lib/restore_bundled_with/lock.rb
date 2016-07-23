module RestoreBundledWith
  # The lock file
  class Lock
    attr_reader :body
    # @!attribute [r] body
    #   @return [String] file body

    REGEX_BUNDLED_WITH = /^(?<pick>(?:\r\n|\r|\n)^BUNDLED WITH.*(?:\r\n|\r|\n).+(?:\r\n|\r|\n))/

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
    #
    # @return [Lock] the lock file instance
    def self.restore(
      data,
      lockfile = Repository::LOCK_FILE,
      ref = Repository::REF,
      git_path = Repository::GIT_PATH,
      git_options = Repository::GIT_OPTIONS,
      new_line = Repository::NEW_LINE
    )
      trimmed = new(data).delete_bundled_with
      lock_file_data = Repository
                       .new(git_path, git_options)
                       .fetch_file(lockfile, ref, new_line)
      section = new(lock_file_data)
                .pick
      insert(trimmed.body, section)
    end

    # @param text [String] the lock file contents
    #
    # @return [Lock] the lock file instance
    def initialize(text)
      @body = text
    end

    # @example delete bundled with
    #   "\n\nBUNDLED WITH\n   1.10.4\n" => "\n"
    #
    # @return [Lock] new lock file instance which is deleted bundled with
    def delete_bundled_with
      self.class.new(body.sub(REGEX_BUNDLED_WITH) { '' })
    end

    # @return [String] pick target section
    def pick
      match = REGEX_BUNDLED_WITH.match(body)
      if match
        match[:pick]
      else
        ''
      end
    end

    # @return [String] the lock file contents
    def to_s
      body
    end

    # @param [#body] other compare body
    #
    # @return [Boolean] true if file body is same
    def ==(other)
      body == other.body
    end
  end
end
