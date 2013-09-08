require "spec_helper"

describe Elrio::ImageOptimizer do
  describe "#detect_cap_insets" do
    let(:path) { "file/path.png" }
    let(:detector) { double(Elrio::Detector) }
    let(:image) { double(ChunkyPNG::Image) }
    let(:columns) { [double] * 5 }
    let(:rows) { [double] * 3 }

    before do
      image.stub(:width).and_return(columns.count)
      image.stub(:height).and_return(rows.count)
      image.stub(:column) {|x| columns[x] }
      image.stub(:row) {|x| rows[x] }

      detector.stub(:detect).with(rows).and_return([1, 3])
      detector.stub(:detect).with(columns).and_return([2, 4])

      Elrio::Detector.stub(:new).and_return(detector)
      ChunkyPNG::Image.stub(:from_file).with(path).and_return(image)
    end

    it "passes the rows and columns to the detector" do
      subject.detect_cap_insets(path).should == [1, 2, 3, 4]
    end
  end
end
