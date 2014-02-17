require "spec_helper"

describe Elrio::PointSize do
  describe ".from_filename" do
    it "should be 2 when the filename includes @2x" do
      Elrio::PointSize.from_filename("image@2x.png").should == 2
    end

    it "should be 1 when the filename does not include @2x" do
      Elrio::PointSize.from_filename("image.png").should == 1
    end
  end
end
