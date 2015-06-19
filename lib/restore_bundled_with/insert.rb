module RestoreBundledWith
  class Insert
    def initialize(body, section)
      @body = body
      @section = section
    end

    def insert
      if @section && !@section.empty?
        @body + @section + "\n"
      else
        @body
      end
    end
  end
end
