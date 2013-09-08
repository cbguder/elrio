require "chunky_png"

module Elrio
  class ImageOptimizer
    def detect_cap_insets(path)
      img = ChunkyPNG::Image.from_file(path)

      columns = (0...img.width).map {|x| img.column(x) }
      rows = (0...img.height).map {|y| img.row(y) }

      detector = Detector.new

      column_info = detector.detect(columns)
      row_info = detector.detect(rows)

      insets = [
        row_info[0],
        column_info[0],
        row_info[1],
        column_info[1]
      ]

      if path =~ /@2x/
        insets.map {|i| (i+1)/2 }
      else
        insets
      end
    end
  end
end
