require "spec_helper"

describe Elrio::ImageOptimizer do
  describe "#optimize" do
    let(:image) { ChunkyPNG::Image.from_file("spec/fixtures/original.png") }
    let(:expected) { ChunkyPNG::Image.from_file("spec/fixtures/optimized.png") }
    let(:insets) { Elrio::Insets.new(48, 48, 48, 48, 1, 1) }

    it "produces the expected image" do
      optimized = subject.optimize(image, insets)
      optimized.should == expected
    end

    it "returns nil if insets are too big" do
      optimized = subject.optimize(image, Elrio::Insets.new(image.height, image.width, 0, 0, 1, 1))
      optimized.should be_nil
    end

    context "with a patterned image" do
      let(:image) { ChunkyPNG::Image.from_file("spec/fixtures/pattern-original.png") }
      let(:expected) { ChunkyPNG::Image.from_file("spec/fixtures/pattern-optimized.png") }
      let(:insets) { Elrio::Insets.new(10, 10, 10, 10, 2, 2) }

      it "produces the expected image" do
        optimized = subject.optimize(image, insets)
        optimized.should == expected
      end
    end
  end
end
