module RestoreBundledWith
  class Lock < ::RestoreFromRepository::File
    REGEX_BUNDLED_WITH = /^(?<pick>(?:\r\n|\r|\n)^BUNDLED WITH.*(?:\r\n|\r|\n).+(?:\r\n|\r|\n))/

    def self.insert(text, section)
      if section && !section.empty?
        new(text + section)
      else
        new(text)
      end
    end
  end
end
