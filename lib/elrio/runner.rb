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
        opt_suffix = "-optimized@2x.png"
        opt_base = path.sub(/@2x/, '')
      else
        opt_suffix = "-optimized.png"
        opt_base = path
      end

      optimized_path = File.join(
        File.dirname(opt_base),
        File.basename(opt_base, ".*") + opt_suffix
      )

      image = ChunkyPNG::Image.from_file(path)

      image_optimizer = ImageOptimizer.new(retina)
      insets = image_optimizer.detect_cap_insets(image)

      optimized = image_optimizer.optimize(image, insets)
      optimized.save(optimized_path) if optimized

      insets
    end

    private

    def is_retina?(path)
      !!(path =~ /@2x/)
    end
  end
end
