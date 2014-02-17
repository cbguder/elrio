module Elrio
  class ImageOptimizer
    def initialize(point_size, cap_inset_detector = CapInsetDetector.new)
      @cap_inset_detector = cap_inset_detector
      @point_size = point_size
    end

    def detect_cap_insets(image)
      pixel_insets = @cap_inset_detector.detect_cap_insets(image)
      multiply_insets(pixel_insets, 1.0 / @point_size)
    end

    def optimize(image, point_insets)
      pixel_insets = multiply_insets(point_insets, @point_size)
      target = target_size(pixel_insets)

      return if target.height > image.height || target.width > image.width

      source_x = image.width - pixel_insets.right
      source_y = image.height - pixel_insets.bottom
      target_x = target.width - pixel_insets.right
      target_y = target.height - pixel_insets.bottom
      source_width = pixel_insets.left + @point_size
      source_height = pixel_insets.top + @point_size

      optimized = ChunkyPNG::Image.new(target.width, target.height)

      copy_rect(
        image,
        optimized,
        Rect.new(0, 0, source_width, source_height),
        Point.new(0, 0)
      )

      copy_rect(
        image,
        optimized,
        Rect.new(source_x, 0, pixel_insets.right, source_height),
        Point.new(target_x, 0)
      )

      copy_rect(
        image,
        optimized,
        Rect.new(0, source_y, source_width, pixel_insets.bottom),
        Point.new(0, target_y)
      )

      copy_rect(
        image,
        optimized,
        Rect.new(source_x, source_y, pixel_insets.right, pixel_insets.bottom),
        Point.new(target_x, target_y)
      )

      optimized
    end

    private

    def copy_rect(src, dest, src_rect, dest_origin)
      (0...src_rect.width).each do |x|
        (0...src_rect.height).each do |y|
          src_x = src_rect.x + x
          src_y = src_rect.y + y

          dest_x = dest_origin.x + x
          dest_y = dest_origin.y + y

          dest[dest_x, dest_y] = src[src_x, src_y]
        end
      end
    end

    def target_size(insets)
      height = insets.top + insets.bottom + @point_size
      width = insets.left + insets.right + @point_size

      Size.new(width, height)
    end

    def multiply_insets(insets, factor)
      Insets.new(
        (factor * insets.top).ceil,
        (factor * insets.left).ceil,
        (factor * insets.bottom).ceil,
        (factor * insets.right).ceil
      )
    end
  end
end
