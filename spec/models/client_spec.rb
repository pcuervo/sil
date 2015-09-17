require 'spec_helper'

RSpec.describe Client, type: :model do
  let(:client){ FactoryGirl.create :client }
  subject{ client }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
end
