module Elrio
  class CapInsetDetector
    def initialize(pattern_detector = PatternDetector.new)
      @pattern_detector = pattern_detector
    end

    def detect_cap_insets(image)
      columns = (0...image.width).map { |x| image.column(x) }
      rows = (0...image.height).map { |y| image.row(y) }

      horizontal_pattern = @pattern_detector.detect_pattern(columns)
      vertical_pattern = @pattern_detector.detect_pattern(rows)

      Insets.new(
        vertical_pattern[0],
        horizontal_pattern[0],
        vertical_pattern[1],
        horizontal_pattern[1]
      )
    end
  end
end
