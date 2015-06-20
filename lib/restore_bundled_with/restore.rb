module RestoreBundledWith
  class Restore
    def initialize(
      data,
      lockfile = Fetch::LOCK_FILE,
      ref = Fetch::REF,
      git_path = Fetch::GIT_PATH,
      git_options = Fetch::GIT_OPTIONS,
      new_line = Insert::NEW_LINE
    )
      @data = data
      @lockfile = lockfile
      @ref = ref
      @git_path = git_path
      @git_options = git_options
      @new_line = new_line
    end

    def restore
      data = Delete.new(@data).delete
      section = Fetch
                .new(
                  @lockfile,
                  @ref,
                  @git_path,
                  @git_options)
                .pick
      @data = Insert.new(data, section, @new_line).insert
    end

    def write
      File.write(@lockfile, @data)
    end

    def to_s
      @data
    end
  end
end
