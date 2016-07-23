module RestoreBundledWith
  class Lock < ::RestoreFromRepository::File
    REGEX_BUNDLED_WITH = /^(?<pick>(?:\r\n|\r|\n)^BUNDLED WITH.*(?:\r\n|\r|\n).+(?:\r\n|\r|\n))/
  end
end
