require "chunky_png"

module Elrio
  class ImageOptimizer
    def detect_cap_insets(path)
      img = ChunkyPNG::Image.from_file(path)

      columns = (0...img.width).map do |x|
        img.column(x)
      end

      rows = (0...img.height).map do |y|
        img.row(y)
      end

      detector = Detector.new

      column_info = detector.detect(columns)
      row_info = detector.detect(rows)

      [
        row_info[0],
        column_info[0],
        row_info[1],
        column_info[1]
      ]
    end
  end
end
