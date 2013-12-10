require 'spec_helper'

require 'array/subindex'
describe 'Array::subindex' do
  describe 'preserve previous functionality' do
    subject { [1,2,3] }
    it "returns normal index values with integer indexes" do
      expect(subject[0]).to eq(1)
      expect(subject[1]).to eq(2)
      expect(subject[2]).to eq(3)

      expect(subject[-1]).to eq(3)
    end
  end

  context "adjacent values are numeric" do
    subject { [1,2,3] }
    it "will add parts equally" do
      # half of index 1 + half of index 2
      expect(
        subject[1.5]
      ).to eq( 1.0 + 1.5)
    end

    it "will add parts unequally" do
      # 1/4 of index 0 + 3/4 of index 1
      expect(
        subject[0.25]
      ).to eq( 0.25 + 1.5)
    end

    it "will round values" do
      # expect 0.001 of index 1 and 0.998 index 2, but rounded to 2.999
      expect(
        subject[1.001]
      ).to eq( 2.999)
    end
  end

  context "adjacent values are strings" do
    subject { %w{ this is a test } }
    it "concats fractional strings equally" do
      expect(
        subject[0.5]
      ).to eq(
        "isi"
      )
    end

    it "concats fractional strings unequally" do
      expect(
        subject[0.25]
      ).to eq(
        "hisi"
      )
    end

    it "rounds uneven indexes down" do
      uneven_length_strings = %w{ foo bar baz }

      expect(
        uneven_length_strings[0.5]
      ).to eq(
        "oob"
      )   
    end
  end

  context "adjacent values are mix of string and numeric" do
    subject { ["foo", 100] }

    it "will treat all elements as strings" do
      expect(
        subject[0.5]
      ).to eq(
        "oo1"
      )
    end
  end

  context "array contains elements that are array-like" do
    context "array-like element is full of numbers" do
      subject { [ [ 1, 2 ], [ 3, 4] ] } 
      it "returns the array indexes added together" do
        # [2] + [3], then 0.5 of result
        expect(
          subject[0.5]
        ).to eq(
          2.5
        )
      end
    end

    context "array-like element is not numbers" do
      subject { [ %w[foo bar], %w[baz qux] ] }
      it "will return concatenated strings" do
        expect(
          subject[0.5]
        ).to eq(
          "arb"
        )

      end
    end
  end

  context "an adjacent value is numeric/string/array" do
    subject { [ ['foo'], { :bar => 'baz' } ] }
    it "will coerce them in to strings" do
      expect(
        subject[0.5]
      ).to eq(
        'oobar'
      )
    end
  end

end