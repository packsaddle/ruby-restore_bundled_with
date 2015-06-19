module RestoreBundledWith
  class Insert
    def initialize(body, section)
      @body = body
      @section = section
    end

    def insert
      @body + @section + "\n"
    end
  end
end
