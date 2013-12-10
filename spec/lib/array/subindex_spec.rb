require 'spec_helper'

require 'array/subindex'
describe 'Array::subindex' do
  describe 'preserve previous functionality' do
    subject { [1,2,3] }
    it "should return normal index values" do
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
  end

  context "adjacent values are mix of string and numeric" do
  end

  context "and adjacent value is neither numeric or string" do
  end

end