module Elrio
  class ImageOptimizer
    def optimize(image, pixel_insets)
      target = target_size(pixel_insets)

      return if target.height > image.height || target.width > image.width

      source_x = image.width - pixel_insets.right
      source_y = image.height - pixel_insets.bottom
      target_x = target.width - pixel_insets.right
      target_y = target.height - pixel_insets.bottom
      source_width = pixel_insets.left + pixel_insets.pattern_width
      source_height = pixel_insets.top + pixel_insets.pattern_height

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
      height = insets.top + insets.bottom + insets.pattern_height
      width = insets.left + insets.right + insets.pattern_width

      Size.new(width, height)
    end
  end
end
