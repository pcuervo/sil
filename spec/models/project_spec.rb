require 'spec_helper'

RSpec.describe Project, type: :model do
  before { @user = FactoryGirl.build(:project) }

  it { should respond_to(:name) }
  it { should respond_to(:litobel_id) }

  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:litobel_id) }

  it { should be_valid }
end