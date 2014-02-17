require "spec_helper"

describe Elrio::Runner do
  let(:image) { double(ChunkyPNG::Image) }
  let(:optimized) { double(ChunkyPNG::Image) }
  let(:image_optimizer) { double(Elrio::ImageOptimizer) }
  let(:cap_inset_detector) { double(Elrio::CapInsetDetector) }
  let(:insets) { Elrio::Insets.new(1, 2, 3, 4, 5, 6) }
  let(:path) { "file/path.png".freeze }

  before do
    ChunkyPNG::Image.stub(:from_file).with(path).and_return(image)
    cap_inset_detector.stub(:detect_cap_insets).with(image).and_return(insets)
  end

  subject { Elrio::Runner.new(cap_inset_detector, image_optimizer) }

  describe "#analyze" do
    it "returns the cap insets detected by the detector when point size is 1" do
      Elrio::PointSize.stub(:from_filename).with(path).and_return(1)
      subject.analyze(path).should == Elrio::Insets.new(1, 2, 3, 4, 5, 6)
    end

    it "halves the cap insets detected by the detector when point size is 2" do
      Elrio::PointSize.stub(:from_filename).with(path).and_return(2)
      subject.analyze(path).should == Elrio::Insets.new(1, 1, 2, 2, 5, 6)
    end
  end

  describe "#optimize" do
    context "when the image is optimizable" do
      before do
        image_optimizer.stub(:optimize).with(image, insets).and_return(optimized)
        optimized.should_receive(:save).with("file/path-optimized.png")
      end

      it "returns the cap insets detected by the optimizer when point size is 1" do
        Elrio::PointSize.stub(:from_filename).with(path).and_return(1)
        subject.optimize(path).should == Elrio::Insets.new(1, 2, 3, 4, 5, 6)
      end

      it "halves the cap insets detected by the detector when point size is 2" do
        Elrio::PointSize.stub(:from_filename).with(path).and_return(2)
        subject.optimize(path).should == Elrio::Insets.new(1, 1, 2, 2, 5, 6)
      end
    end

    context "when the image is not optimizable" do
      before do
        image_optimizer.stub(:optimize).with(image, insets).and_return(nil)
      end

      it "does not blow up" do
        -> { subject.optimize(path) }.should_not raise_exception
      end
    end
  end
end
