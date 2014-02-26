require "values"

module Elrio
  Point = Value.new(:x, :y)

  Size = Value.new(:width, :height)

  Rect = Value.new(:x, :y, :width, :height)

  Pattern = Value.new(:start, :end, :size)

  class Insets < Value.new(:top, :left, :bottom, :right, :pattern_width, :pattern_height)
    def to_s
      [top, left, bottom, right].to_s
    end

    def *(factor)
      Insets.new(
        (factor * top).ceil,
        (factor * left).ceil,
        (factor * bottom).ceil,
        (factor * right).ceil,
        pattern_width,
        pattern_height
      )
    end

    def /(factor)
      self * (1.0 / factor)
    end

    def coerce(number)
      [self, number]
    end
  end
end
