module Aozora
  class LoopFile < File
    def getc
      super || begin
        rewind
        super
      end
    end
  end
end
