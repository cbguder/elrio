module Elrio
  class CLI
    def initialize(output = $stdout)
      @output = output
    end

    def run(args)
      runner = Runner.new
      cmd = args.shift

      args.each do |path|
        insets = runner.send(cmd, path)
        @output.puts "#{path}: #{insets}"
      end
    end
  end
end
