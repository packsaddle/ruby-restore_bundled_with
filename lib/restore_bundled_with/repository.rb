module RestoreBundledWith
  # The git repository
  class Repository < RestoreFromRepository::Repository
    LOCK_FILE = 'Gemfile.lock'.freeze

    # @param file [String] target file
    # @param ref [String] git ref
    # @param new_line [String] file's ending new line
    #
    # @return [String] target file contents
    def fetch_file(file = LOCK_FILE, ref = REF, new_line = NEW_LINE)
      # NOTE: git.cat_file trims last \n?
      text = git.cat_file("#{ref}:#{file}")
      text + new_line
    end
  end
end
