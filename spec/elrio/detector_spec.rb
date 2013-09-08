require "spec_helper"

describe Elrio::Detector do
  describe "#detect" do
    it "returns the non-repeating prefix and suffix lengths of a collection" do
      data = %w(A - - - B C)
      subject.detect(data).should == [1, 2]
    end

    it "returns zero when all items are the same" do
      data = %w(- - -)
      subject.detect(data).should == [0, 0]
    end

    it "returns the length of the collection when all items are unique" do
      data = %w(A B C D E)
      subject.detect(data).should == [5, 0]
    end

    it "does not fail with a single-item collection" do
      data = %w(A)
      subject.detect(data).should == [1, 0]
    end

    it "can handle multiple runs" do
      data = %w(A A A B C - - - - - D E F F F)
      subject.detect(data).should == [5, 5]
    end

    it "can handle longest runs at the beginning" do
      data = %w(- - - A)
      subject.detect(data).should == [0, 1]
    end

    it "can handle longest runs at the end" do
      data = %w(A - - -)
      subject.detect(data).should == [1, 0]
    end
  end
end
