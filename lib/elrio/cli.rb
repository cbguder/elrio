module Elrio
  class CLI
    def initialize(output = $stdout)
      @output = output
    end

    def run(args)
      optimizer = ImageOptimizer.new

      args.each do |path|
        insets = optimizer.detect_cap_insets(path)
        @output.puts "#{path}: #{insets}"
      end
    end
  end
end
