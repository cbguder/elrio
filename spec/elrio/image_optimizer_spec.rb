require "spec_helper"

describe Elrio::ImageOptimizer do
  describe "#detect_cap_insets" do
    let(:cap_inset_detector) { double(Elrio::PatternDetector) }
    let(:image) { double(ChunkyPNG::Image) }
    let(:columns) { [double] * 5 }
    let(:rows) { [double] * 3 }

    before do
      image.stub(:width).and_return(columns.count)
      image.stub(:height).and_return(rows.count)
      image.stub(:column) {|x| columns[x] }
      image.stub(:row) {|x| rows[x] }

      cap_inset_detector.stub(:detect_cap_insets).with(rows).and_return([1, 3])
      cap_inset_detector.stub(:detect_cap_insets).with(columns).and_return([2, 4])

      Elrio::PatternDetector.stub(:new).and_return(cap_inset_detector)
    end

    context "in non-retina mode" do
      subject { Elrio::ImageOptimizer.new(false) }

      it "passes the rows and columns to the detector" do
        subject.detect_cap_insets(image).should == Elrio::Insets.new(1, 2, 3, 4)
      end
    end

    context "in retina mode" do
      subject { Elrio::ImageOptimizer.new(true) }

      it "halves the cap insets" do
        subject.detect_cap_insets(image).should == Elrio::Insets.new(1, 1, 2, 2)
      end
    end
  end

  describe "#optimize" do
    let(:image) { ChunkyPNG::Image.from_file("spec/fixtures/original.png") }

    context "in non-retina mode" do
      let(:expected) { ChunkyPNG::Image.from_file("spec/fixtures/optimized.png") }

      subject { Elrio::ImageOptimizer.new(false) }

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

    context "in retina mode" do
      let(:expected) { ChunkyPNG::Image.from_file("spec/fixtures/optimized@2x.png") }

      subject { Elrio::ImageOptimizer.new(true) }

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
