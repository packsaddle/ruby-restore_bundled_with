module RestoreBundledWith
  class Repository
    LOCK_FILE = 'Gemfile.lock'.freeze
    REF = 'HEAD'.freeze
    GIT_PATH = '.'.freeze
    GIT_OPTIONS = {}.freeze
    NEW_LINE = "\n".freeze

    def initialize(git_path = GIT_PATH, git_options = GIT_OPTIONS)
      @git_path = git_path
      @git_options = git_options
    end

    def git
      @git ||= Git.open(@git_path, @git_options)
    end

    def fetch_file(file = LOCK_FILE, ref = REF, new_line = NEW_LINE)
      # NOTE: git.cat_file trims last \n?
      text = git.cat_file("#{ref}:#{file}")
      text + new_line
    end
  end
end
