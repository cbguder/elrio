require "spec_helper"

describe Elrio::Runner do
  let(:image) { double(ChunkyPNG::Image) }
  let(:optimized) { double(ChunkyPNG::Image) }
  let(:image_optimizer) { double(Elrio::ImageOptimizer) }
  let(:insets) { double(Elrio::Insets) }
  let(:point_size) { double(Fixnum) }
  let(:path) { "file/path.png".freeze }

  before do
    ChunkyPNG::Image.stub(:from_file).with(path).and_return(image)
    Elrio::PointSize.stub(:from_filename).with(path).and_return(point_size)
    image_optimizer.stub(:detect_cap_insets).and_return(insets)
  end

  describe "#analyze" do
    before do
      Elrio::ImageOptimizer.should_receive(:new).with(point_size).and_return(image_optimizer)
    end

    it "returns the cap insets detected by the optimizer" do
      subject.analyze(path).should == insets
    end
  end

  describe "#optimize" do
    context "when the image is optimizable" do
      before do
        image_optimizer.stub(:optimize).with(image, insets).and_return(optimized)
      end

      before do
        Elrio::ImageOptimizer.should_receive(:new).with(point_size).and_return(image_optimizer)
        optimized.should_receive(:save).with("file/path-optimized.png")
      end

      it "returns the cap insets detected by the optimizer" do
        subject.optimize(path).should == insets
      end
    end

    context "when the image is not optimizable" do
      before do
        Elrio::ImageOptimizer.should_receive(:new).and_return(image_optimizer)
        image_optimizer.stub(:optimize).with(image, insets).and_return(nil)
      end

      it "does not blow up" do
        -> { subject.optimize(path) }.should_not raise_exception
      end
    end
  end
end
