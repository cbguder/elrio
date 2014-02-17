require "chunky_png"

module Elrio
  class Runner
    def initialize(cap_inset_detector = CapInsetDetector.new, image_optimizer = ImageOptimizer.new)
      @cap_inset_detector = cap_inset_detector
      @image_optimizer = image_optimizer
    end

    def analyze(path)
      image = ChunkyPNG::Image.from_file(path)
      point_size = PointSize.from_filename(path)
      insets = @cap_inset_detector.detect_cap_insets(image)
      insets / point_size
    end

    def optimize(path)
      image = ChunkyPNG::Image.from_file(path)
      point_size = PointSize.from_filename(path)
      insets = @cap_inset_detector.detect_cap_insets(image)

      opt_suffix = "-optimized.png"
      opt_base = path

      optimized_path = File.join(
        File.dirname(opt_base),
        File.basename(opt_base, ".*") + opt_suffix
      )

      optimized = @image_optimizer.optimize(image, insets)
      optimized.save(optimized_path) if optimized

      insets / point_size
    end
  end
end
