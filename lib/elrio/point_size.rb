module Elrio
  class PointSize
    def self.from_filename(filename)
      filename =~ /@2x/ ? 2 : 1
    end
  end
end
