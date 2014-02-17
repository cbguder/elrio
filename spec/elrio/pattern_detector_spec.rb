require "spec_helper"

describe Elrio::PatternDetector do
  describe "#detect_cap_insets" do
    it "returns the non-repeating prefix and suffix lengths of a collection" do
      data = %w(A - - - B C)
      subject.detect_pattern(data).should == Elrio::Pattern.new(1, 2, 1)
    end

    it "returns zero when all items are the same" do
      data = %w(- - -)
      subject.detect_pattern(data).should == Elrio::Pattern.new(0, 0, 1)
    end

    it "returns the length of the collection when all items are unique" do
      data = %w(A B C D E)
      subject.detect_pattern(data).should == Elrio::Pattern.new(5, 0, 1)
    end

    it "does not fail with a single-item collection" do
      data = %w(A)
      subject.detect_pattern(data).should == Elrio::Pattern.new(1, 0, 1)
    end

    it "can handle multiple runs" do
      data = %w(A A A B C - - - - - D E F F F)
      subject.detect_pattern(data).should == Elrio::Pattern.new(5, 5, 1)
    end

    it "can handle longest runs at the beginning" do
      data = %w(- - - A)
      subject.detect_pattern(data).should == Elrio::Pattern.new(0, 1, 1)
    end

    it "can handle longest runs at the end" do
      data = %w(A - - -)
      subject.detect_pattern(data).should == Elrio::Pattern.new(1, 0, 1)
    end

    it "can handle patterns" do
      data = %w(- A B A B A B -)
      subject.detect_pattern(data).should == Elrio::Pattern.new(1, 1, 2)
    end
  end
end
