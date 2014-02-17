require "spec_helper"

describe Elrio::CapInsetDetector do
  describe "#detect_cap_insets" do
    let(:pattern_detector) { double(Elrio::PatternDetector) }
    let(:image) { double(ChunkyPNG::Image) }
    let(:columns) { [double] * 5 }
    let(:rows) { [double] * 3 }

    subject { Elrio::CapInsetDetector.new(pattern_detector) }

    before do
      image.stub(:width).and_return(columns.count)
      image.stub(:height).and_return(rows.count)
      image.stub(:column) { |x| columns[x] }
      image.stub(:row) { |x| rows[x] }

      vertical_pattern = Elrio::Pattern.new(1, 3, 5)
      horizontal_pattern = Elrio::Pattern.new(2, 4, 6)

      pattern_detector.stub(:detect_pattern).with(rows).and_return(vertical_pattern)
      pattern_detector.stub(:detect_pattern).with(columns).and_return(horizontal_pattern)
    end

    it "passes the rows and columns to the detector" do
      subject.detect_cap_insets(image).should == Elrio::Insets.new(1, 2, 3, 4, 5, 6)
    end
  end
end
