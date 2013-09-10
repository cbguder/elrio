require "chunky_png"

module Elrio
  class Runner
    def analyze(path)
      image = ChunkyPNG::Image.from_file(path)
      image_optimizer = ImageOptimizer.new(is_retina?(path))
      image_optimizer.detect_cap_insets(image)
    end

    def optimize(path)
      retina = is_retina?(path)

      if retina
        suffix = "-optimized@2x.png"
        path.sub!(/@2x/, '')
      else
        suffix = "-optimized.png"
      end

      optimized_path = File.join(
        File.dirname(path),
        File.basename(path, ".*") + suffix
      )

      image = ChunkyPNG::Image.from_file(path)

      image_optimizer = ImageOptimizer.new(retina)
      insets = image_optimizer.detect_cap_insets(image)

      optimized = image_optimizer.optimize(image, insets)
      optimized.save(optimized_path)

      insets
    end

    private

    def is_retina?(path)
      !!(path =~ /@2x/)
    end
  end
end
