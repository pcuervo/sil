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

  it { should validate_uniqueness_of :serial_number }

end
