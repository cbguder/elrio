module Elrio
  class ImageOptimizer
    def initialize(retina)
      @retina = retina
    end

    def detect_cap_insets(image)
      insets = detect_cap_insets_in_pixels(image)

      if @retina
        halve_insets(insets)
      else
        insets
      end
    end

    def optimize(image, insets)
      insets = double_insets(insets) if @retina
      target = target_size(insets)

      return if target.height > image.height || target.width > image.width

      source_x = image.width - insets.right
      source_y = image.height - insets.bottom
      target_x = target.width - insets.right
      target_y = target.height - insets.bottom

      optimized = ChunkyPNG::Image.new(target.width, target.height)

      copy_rect(
        image,
        optimized,
        Rect.new(0, 0, insets.left + repeatable_size, insets.top + repeatable_size),
        Point.new(0, 0)
      )

      copy_rect(
        image,
        optimized,
        Rect.new(source_x, 0, insets.right, insets.top + repeatable_size),
        Point.new(target_x, 0)
      )

      copy_rect(
        image,
        optimized,
        Rect.new(0, source_y, insets.left + repeatable_size, insets.bottom),
        Point.new(0, target_y)
      )

      copy_rect(
        image,
        optimized,
        Rect.new(source_x, source_y, insets.right, insets.bottom),
        Point.new(target_x, target_y)
      )

      optimized
    end

    private

    def detect_cap_insets_in_pixels(image)
      columns = (0...image.width).map {|x| image.column(x) }
      rows = (0...image.height).map {|y| image.row(y) }

      detector = CapInsetDetector.new

      column_info = detector.detect_cap_insets(columns)
      row_info = detector.detect_cap_insets(rows)

      Insets.new(
        row_info[0],
        column_info[0],
        row_info[1],
        column_info[1]
      )
    end

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

    def halve_insets(insets)
      Insets.new(
        (insets.top    + 1) / 2,
        (insets.left   + 1) / 2,
        (insets.bottom + 1) / 2,
        (insets.right  + 1) / 2
      )
    end

    def double_insets(insets)
      Insets.new(
        insets.top    * 2,
        insets.left   * 2,
        insets.bottom * 2,
        insets.right  * 2
      )
    end

    def target_size(insets)
      height = insets.top + insets.bottom + repeatable_size
      width = insets.left + insets.right + repeatable_size

      Size.new(width, height)
    end

    def repeatable_size
      @retina ? 2 : 1
    end
  end
end
