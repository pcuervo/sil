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
end
