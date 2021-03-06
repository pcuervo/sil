require 'spec_helper'

class Transaction
  include Transactionable
end

describe Transactionable do 
  let(:inventory_transaction) { Transaction.new }
  subject { inventory_transaction }

  describe "#log_transaction" do
    before do
      @unit_item = FactoryGirl.create :inventory_item
    end

    it "returns true when the inventory transaction was recorded" do
      expect(inventory_transaction.log_transaction( Time.now.to_datetime, @unit_item.id, 'Entrada unitaria', 'temporal', Date.today, 'These are my comments', 'HP', 'Roberto Perez - 55443322')).to eq (true)
    end

    it "returns false when the inventory transaction was not recorded" do
      expect(inventory_transaction.log_transaction( Time.now.to_datetime, @unit_item.id, 'Entrada unitaria', 'temporal', Date.today, 'These are my comments', 'HP', 'Roberto Perez - 55443322')).to eq (true)
    end    

  end
end