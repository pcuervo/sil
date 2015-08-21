require 'spec_helper'

describe User do
  before { @user = FactoryGirl.build(:user) }

  subject { @user }

  #it { should respond_to(:first_name) }
  #it { should respond_to(:last_name) }
  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  #it { should respond_to(:role) }

  #it { should validate_presence_of(:first_name) }
  #it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }
	it { should validate_uniqueness_of(:email) }
	it { should validate_confirmation_of(:password) }
	#it { should validate_presence_of(:role) }
	it { should allow_value('example@domain.com').for(:email) }

  it { should be_valid }
end
