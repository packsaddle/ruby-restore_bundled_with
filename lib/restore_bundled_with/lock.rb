module RestoreBundledWith
  class Lock
    attr_reader :body

    NEW_LINE = "\n"
    REGEX_BUNDLED_WITH = /^\n^BUNDLED WITH.*\n.+\n/

    def self.insert(text, section, new_line = NEW_LINE)
      if section && !section.empty?
        new(text + section + new_line)
      else
        new(text)
      end
    end

    def initialize(text)
      @body = text
    end

    # "\n\nBUNDLED WITH\n   1.10.4\n" => "\n"
    def delete_bundled_with
      self.class.new(body.sub(REGEX_BUNDLED_WITH) { '' })
    end

    def to_s
      body
    end

    def ==(other)
      body == other.body
    end
  end
end