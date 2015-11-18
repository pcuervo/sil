require 'spec_helper'

describe BundleItem, type: :model do
  let(:bundle_item) { FactoryGirl.create :bundle_item }
  subject { bundle_item }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:image_url) }
  it { should respond_to(:status) }
  it { should respond_to(:item_type) }
  it { should respond_to(:barcode) }
  it { should respond_to(:num_parts) }
  it { should respond_to(:is_complete) }

  it { should have_many(:bundle_item_parts) }

  it { should validate_numericality_of(:num_parts) }
  it { should_not allow_value(-1).for(:num_parts) }
  it { should allow_value(0).for(:num_parts) }

  describe ".update_num_parts" do
    before(:each) do
      @bundle_item = FactoryGirl.create :bundle_item
      @part1 = FactoryGirl.create :bundle_item_part
      @part2 = FactoryGirl.create :bundle_item_part
      @part3 = FactoryGirl.create :bundle_item_part
      @bundle_item.bundle_item_parts << @part1
      @bundle_item.bundle_item_parts << @part2
      @bundle_item.bundle_item_parts << @part3
    end

    it "updates the number of parts" do
      @bundle_item.update_num_parts
      expect(@bundle_item.num_parts).to eql 3
    end
  end

  describe ".add_parts" do
    before(:each) do
      @bundle_item = FactoryGirl.create :bundle_item
      @part1 = FactoryGirl.attributes_for :bundle_item_part
      @part2 = FactoryGirl.attributes_for :bundle_item_part
      @parts_arr = [ @part1, @part2 ]
    end

    it "returns the number of parts added" do
      @bundle_item.add_parts( @parts_arr )
      expect(@bundle_item.num_parts).to eql 2
    end
  end
end
