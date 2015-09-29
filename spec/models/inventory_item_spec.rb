require 'spec_helper'

describe InventoryItem do
  let(:inventory_item) { FactoryGirl.build :inventory_item }
  subject { inventory_item }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:image_url) }
  it { should respond_to(:status) }

  # Required fields
  it { should validate_presence_of :name }
  it { should validate_presence_of :status }

  # Required relations
  it { should validate_presence_of(:user)}
  it { should validate_presence_of(:project) }
  it { should validate_presence_of(:client) }

  it { should belong_to :user }
  it { should belong_to :project }
  it { should belong_to :client }
end