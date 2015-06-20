module RestoreBundledWith
  class Restore
    def initialize(
      data,
      lockfile = Repository::LOCK_FILE,
      ref = Repository::REF,
      git_path = Repository::GIT_PATH,
      git_options = Repository::GIT_OPTIONS,
      new_line = Repository::NEW_LINE
    )
      @data = data
      @lockfile = lockfile
      @ref = ref
      @git_path = git_path
      @git_options = git_options
      @new_line = new_line
    end

    def restore
      data = Lock.new(@data).delete_bundled_with.to_s
      lock_file = Repository
                  .new(@git_path, @git_options)
                  .fetch_file(@lockfile, @ref, @new_line)
      section = Lock
                .new(lock_file)
                .pick
      @data = Lock.insert(data, section).to_s
    end

    def write
      File.write(@lockfile, @data)
    end

    def to_s
      @data
    end
  end
end
