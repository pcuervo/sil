require 'spec_helper'

describe UnitItem do

  let(:unit_item) { FactoryGirl.create :unit_item }
  subject { unit_item }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:image_url) }
  it { should respond_to(:status) }
  it { should respond_to(:serial_number) }
  it { should respond_to(:brand) }
  it { should respond_to(:model) }

  # Required relations
  it { should validate_presence_of(:user)}
  it { should validate_presence_of(:project) }
  it { should validate_presence_of(:client) }
  
  it { should validate_uniqueness_of :serial_number }

end
