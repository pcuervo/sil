require 'spec_helper'

RSpec.describe Project, type: :model do

  let(:project){ FactoryGirl.create :project }
  subject{ project }


  it { should respond_to(:name) }
  it { should respond_to(:litobel_id) }

  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:litobel_id) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:litobel_id) }

  it { should belong_to(:user) }

  it { should be_valid }

end
