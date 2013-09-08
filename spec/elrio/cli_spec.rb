require "spec_helper"

describe Elrio::CLI do
  let(:output) { double(:output) }

  subject { Elrio::CLI.new(output) }

  describe "#run" do
    let(:optimizer) { double(Elrio::ImageOptimizer) }

    before do
      optimizer.stub(:detect_cap_insets).and_return([1, 2, 3, 4])
      Elrio::ImageOptimizer.stub(:new).and_return(optimizer)
    end

    it "prints the cap insets for each file" do
      args = %w(foo bar baz)

      args.each do |arg|
        optimizer.should_receive(:detect_cap_insets).with(arg)
        output.should_receive(:puts).with("#{arg}: [1, 2, 3, 4]")
      end

      subject.run(args)
    end
  end
end
