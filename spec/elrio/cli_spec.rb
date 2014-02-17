require "spec_helper"

describe Elrio::CLI do
  let(:output) { double(:output) }

  subject { Elrio::CLI.new(output) }

  describe "#run" do
    let(:runner) { double(Elrio::Runner) }

    before do
      Elrio::Runner.stub(:new).and_return(runner)
    end

    context "when run without a command" do
      it "prints usage instructions" do
        output.should_receive(:puts).with(/Usage: elrio <command> <images>/)
        subject.run([])
      end
    end

    context "when run with the analyze command" do
      before do
        runner.stub(:analyze).and_return(Elrio::Insets.new(1, 2, 3, 4, 5, 6))
      end

      it "prints the cap insets for each file" do
        args = %w(analyze foo bar)

        args[1..-1].each do |arg|
          runner.should_receive(:analyze).with(arg)
          output.should_receive(:puts).with("#{arg}: [1, 2, 3, 4]")
        end

        subject.run(args)
      end
    end

    context "when run with the optimize command" do
      before do
        runner.stub(:optimize).and_return(Elrio::Insets.new(1, 2, 3, 4, 5, 6))
      end

      it "prints the cap insets for each file" do
        args = %w(optimize foo bar)

        args[1..-1].each do |arg|
          runner.should_receive(:optimize).with(arg)
          output.should_receive(:puts).with("#{arg}: [1, 2, 3, 4]")
        end

        subject.run(args)
      end
    end
  end
end
