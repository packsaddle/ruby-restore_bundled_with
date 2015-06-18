module RestoreBundledWith
  class Trim
    REGEX_BUNDLED_WITH = /^\n^BUNDLED WITH.*\n.+\n/
    def initialize(text)
      @text = text
    end

    # "\n\nBUNDLED WITH\n   1.10.4\n" => "\n"
    def trim
      @text.sub(REGEX_BUNDLED_WITH) { '' }
    end
  end
end
