require "spec_helper"

describe Elrio::ImageOptimizer do
  describe "#detect_cap_insets" do
    let(:cap_inset_detector) { double(Elrio::CapInsetDetector) }
    let(:image) { double(ChunkyPNG::Image) }

    before do
      insets = Elrio::Insets.new(1, 2, 3, 4)
      cap_inset_detector.stub(:detect_cap_insets).with(image).and_return(insets)
    end

    context "with a point size of 1" do
      subject { Elrio::ImageOptimizer.new(1, cap_inset_detector) }

      it "returns the detected cap insets" do
        subject.detect_cap_insets(image).should == Elrio::Insets.new(1, 2, 3, 4)
      end
    end

    context "with a point size of 2" do
      subject { Elrio::ImageOptimizer.new(2, cap_inset_detector) }

      it "halves the detected cap insets" do
        subject.detect_cap_insets(image).should == Elrio::Insets.new(1, 1, 2, 2)
      end
    end
  end

  describe "#optimize" do
    let(:image) { ChunkyPNG::Image.from_file("spec/fixtures/original.png") }

    context "with a point size of 1" do
      let(:expected) { ChunkyPNG::Image.from_file("spec/fixtures/optimized.png") }

      subject { Elrio::ImageOptimizer.new(1) }

      it "produces the expected image" do
        optimized = subject.optimize(image, Elrio::Insets.new(48, 48, 48, 48))
        optimized.should == expected
      end

      it "does not modify the insets" do
        insets = Elrio::Insets.new(48, 48, 48, 48)
        subject.optimize(image, insets)
        insets.should == Elrio::Insets.new(48, 48, 48, 48)
      end

      it "returns nil if insets are too big" do
        optimized = subject.optimize(image, Elrio::Insets.new(image.height, image.width, 0, 0))
        optimized.should be_nil
      end
    end

    context "with a point size of 2" do
      let(:expected) { ChunkyPNG::Image.from_file("spec/fixtures/optimized@2x.png") }

      subject { Elrio::ImageOptimizer.new(2) }

      it "produces the expected image" do
        optimized = subject.optimize(image, Elrio::Insets.new(24, 24, 24, 24))
        optimized.should == expected
      end

      it "does not modify the insets" do
        insets = Elrio::Insets.new(24, 24, 24, 24)
        subject.optimize(image, insets)
        insets.should == Elrio::Insets.new(24, 24, 24, 24)
      end

      it "returns nil if insets are too big" do
        optimized = subject.optimize(image, Elrio::Insets.new(image.height / 2, image.width / 2, 0, 0))
        optimized.should be_nil
      end
    end
  end
end
