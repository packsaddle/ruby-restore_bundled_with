module RestoreFromRepository
  # The git repository
  class Repository
    LOCK_FILE = 'Gemfile.lock'.freeze
    REF = 'HEAD'.freeze
    GIT_PATH = '.'.freeze
    GIT_OPTIONS = {}.freeze
    NEW_LINE = "\n".freeze

    # @param git_path [String] git repository path
    # @param git_options [Hash] ruby-git options
    #
    # @return [Repository] Repository instance
    def initialize(git_path = GIT_PATH, git_options = GIT_OPTIONS)
      @git_path = git_path
      @git_options = git_options
    end

    # @return [Git::Base] ruby-git object
    def git
      @git ||= Git.open(@git_path, @git_options)
    end

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
