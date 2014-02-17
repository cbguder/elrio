require "chunky_png"

module Elrio
  class Runner
    def analyze(path)
      image = ChunkyPNG::Image.from_file(path)
      point_size = PointSize.from_filename(path)
      image_optimizer = ImageOptimizer.new(point_size)
      image_optimizer.detect_cap_insets(image)
    end

    def optimize(path)
      image = ChunkyPNG::Image.from_file(path)
      point_size = PointSize.from_filename(path)
      image_optimizer = ImageOptimizer.new(point_size)
      insets = image_optimizer.detect_cap_insets(image)

      opt_suffix = "-optimized.png"
      opt_base = path

      optimized_path = File.join(
        File.dirname(opt_base),
        File.basename(opt_base, ".*") + opt_suffix
      )

      optimized = image_optimizer.optimize(image, insets)
      optimized.save(optimized_path) if optimized

      insets
    end
  end
end
