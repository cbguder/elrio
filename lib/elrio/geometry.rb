module Elrio
  Point = Struct.new(:x, :y)

  Size = Struct.new(:width, :height)

  Rect = Struct.new(:x, :y, :width, :height)

  Insets = Struct.new(:top, :left, :bottom, :right) do
    def to_s
      [top, left, bottom, right].to_s
    end
  end
end
