require "spec_helper"

describe Elrio::NGramGenerator do
  subject { Elrio::NGramGenerator.new("abcdefghi", 3, 2) }

  describe "#each" do
    it "yields all n-grams of the given string" do
      ngrams = []

      subject.each { |ngram| ngrams << ngram }

      ngrams.should == %w(ab cde fgh i)
    end
  end
end
