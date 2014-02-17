module Elrio
  Point = Struct.new(:x, :y)

  Size = Struct.new(:width, :height)

  Rect = Struct.new(:x, :y, :width, :height)

  Pattern = Struct.new(:start, :end, :size)

  Insets = Struct.new(:top, :left, :bottom, :right, :vertical_size, :horizontal_size) do
    def to_s
      [top, left, bottom, right].to_s
    end

    def *(factor)
      Insets.new(
        (factor * top).ceil,
        (factor * left).ceil,
        (factor * bottom).ceil,
        (factor * right).ceil,
        vertical_size,
        horizontal_size
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
