module Elrio
  class CLI
    def initialize(output = $stdout, runner = Runner.new)
      @output = output
      @runner = runner
    end

    def run(args)
      cmd = args.shift

      return usage unless cmd

      args.each do |path|
        insets = @runner.send(cmd, path)
        @output.puts "#{path}: #{insets}"
      end
    end

    private

    def usage
      @output.puts(<<-EOF)
Usage: elrio <command> <images>

Commands:
  analyze   Analyzes each file and prints the resizable cap insets.
  optimize  Creates an optimized version of each file and prints the
            resizable cap insets for the optimized file.
EOF
    end
  end
end
