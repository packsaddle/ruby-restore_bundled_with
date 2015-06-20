module RestoreBundledWith
  class Lock
    NEW_LINE = "\n"
    def self.insert(body, section, new_line = NEW_LINE)
      if section && !section.empty?
        new(body + section + new_line)
      else
        new(body)
      end
    end

    def initialize(body)
      @body = body
    end

    def to_s
      @body
    end
  end
end
