module RestoreBundledWith
  # The git repository
  class Repository < RestoreFromRepository::Repository
    LOCK_FILE = 'Gemfile.lock'.freeze

    # @param file [String] target file
    # @param ref [String] git ref
    # @param new_line [String] file's ending new line
    #
    # @return [String] target file contents
    def fetch_file(file = Lock::FILE_NAME, ref = REF, new_line = NEW_LINE)
      super(file, ref, new_line)
    end
  end
end
