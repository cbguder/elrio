require "chunky_png"

module Elrio
  class Runner
    def initialize(cap_inset_detector = CapInsetDetector.new, image_optimizer = ImageOptimizer.new)
      @cap_inset_detector = cap_inset_detector
      @image_optimizer = image_optimizer
    end

    def analyze(path)
      image = ChunkyPNG::Image.from_file(path)
      scale = PointSize.from_filename(path)
      insets = @cap_inset_detector.detect_cap_insets(image)
      insets / scale
    end

    def optimize(path)
      image = ChunkyPNG::Image.from_file(path)
      scale = PointSize.from_filename(path)
      insets = @cap_inset_detector.detect_cap_insets(image)
      point_insets = insets / scale

      optimized_image = @image_optimizer.optimize(image, insets)

      if optimized_image
        optimized_path = optimized_path_for(path)
        optimized_image.save(optimized_path)
      end

      point_insets
    end

    private

    def optimized_path_for(path)
      File.join(
        File.dirname(path),
        File.basename(path, ".*") + "-optimized.png"
      )
    end
  end
end
