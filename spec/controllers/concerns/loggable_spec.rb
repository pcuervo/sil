require 'spec_helper'

class UserLog
  include Loggable
end

describe Loggable do 
  let(:user_log) { UserLog.new }
  subject { user_log }

  describe "#log" do
    context "when a user is created" do
      before(:each) do
        user = FactoryGirl.create :user
        user_log.log "hi mom"
      end

      it "returns true if the log was registered" do
        #expect(user_log[:name]).to eql @project_attributes[:name]
      end

      #it { should respond_with 201 }
    end
  end
end