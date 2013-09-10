require "spec_helper"

describe Elrio::Runner do
  let(:image) { double(ChunkyPNG::Image) }
  let(:optimized) { double(ChunkyPNG::Image) }
  let(:image_optimizer) { double(Elrio::ImageOptimizer) }
  let(:insets) { double(Elrio::Insets) }

  before do
    ChunkyPNG::Image.stub(:from_file).with(path).and_return(image)
    image_optimizer.stub(:detect_cap_insets).and_return(insets)
  end

  describe "#analyze" do
    context "with a non-retina image" do
      let(:path) { "file/path.png" }

      before do
        Elrio::ImageOptimizer.should_receive(:new).with(false).and_return(image_optimizer)
      end

      it "returns the cap insets detected by the optimizer" do
        subject.analyze(path).should == insets
      end
    end

    context "with a retina image" do
      let(:path) { "file/path@2x.png" }

      before do
        Elrio::ImageOptimizer.should_receive(:new).with(true).and_return(image_optimizer)
      end

      it "returns the cap insets detected by the optimizer" do
        subject.analyze(path).should == insets
      end
    end
  end

  describe "#optimize" do
    before do
      image_optimizer.stub(:optimize).with(image, insets).and_return(optimized)
    end

    context "with a non-retina image" do
      let(:path) { "file/path.png" }

      before do
        Elrio::ImageOptimizer.should_receive(:new).with(false).and_return(image_optimizer)
        optimized.should_receive(:save).with("file/path-optimized.png")
      end

      it "returns the cap insets detected by the optimizer" do
        subject.optimize(path).should == insets
      end
    end

    context "with a retina image" do
      let(:path) { "file/path@2x.png" }

      before do
        Elrio::ImageOptimizer.should_receive(:new).with(true).and_return(image_optimizer)
        optimized.should_receive(:save).with("file/path-optimized@2x.png")
      end

      it "returns the cap insets detected by the optimizer" do
        subject.optimize(path).should == insets
      end
    end
  end
end
