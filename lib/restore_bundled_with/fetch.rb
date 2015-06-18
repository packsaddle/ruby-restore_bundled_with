module RestoreBundledWith
  class Fetch
    LOCK_FILE = 'Gemfile.lock'
    REF = 'HEAD'
    # REGEX_PICK = /^(?<pick>\n^BUNDLED WITH.*\n.+\n)/
    # git.cat_file trims last \n?
    REGEX_PICK = /^(?<pick>\n^BUNDLED WITH.*\n.+)/
    def initialize(
      file = LOCK_FILE,
      ref = REF,
      git_path = '.',
      git_options = {})
      @file = file
      @ref = ref
      @git_path = git_path
      @git_options = git_options
    end

    def pick
      match = REGEX_PICK.match(target_file_contents)
      if match
        match[:pick]
      else
        ''
      end
    end

    def target_file_contents
      git.cat_file("#{@ref}:#{@file}")
    end

    def git
      @git ||= ::Git.open(@git_path, @git_options)
    end
  end
end
