module RestoreBundledWith
  class Insert
    NEW_LINE = "\n"
    def initialize(body, section, new_line = NEW_LINE)
      @body = body
      @section = section
      @new_line = new_line
    end

    def insert
      if @section && !@section.empty?
        @body + @section + @new_line
      else
        @body
      end
    end
  end
end
