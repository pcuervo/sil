require 'spec_helper'

class InventoryTransaction
  include Transactionable
end

describe Transactionable do 
  let(:inventory_transaction) { InventoryTransaction.new }
  subject { inventory_transaction }

  describe "#log_transaction" do
    before do
      @new_user = FactoryGirl.create :user
      @unit_item = FactoryGirl.create :unit_item
    end

    it "returns true when the inventory transaction was recorded" do
      
    end

  end
end