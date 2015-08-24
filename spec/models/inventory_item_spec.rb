require 'spec_helper'

describe InventoryItem do
  let(:inventory_item) { FactoryGirl.build :inventory_item }
  subject { inventory_item }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:image_url) }
  it { should respond_to(:type) }
  it { should respond_to(:status) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :type }
  it { should validate_presence_of :status }
  it { should validate_presence_of :user_id }
end