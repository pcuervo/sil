require 'spec_helper'

RSpec.describe InventoryTransaction, type: :model do
  let(:inventory_transaction) { FactoryGirl.build :inventory_transaction }
  subject { inventory_transaction }

  it { should respond_to(:entry_date) }
  it { should respond_to(:inventory_item_id) }
  it { should respond_to(:concept) }
  it { should respond_to(:storage_type) }
  it { should respond_to(:estimated_issue_date) }
  it { should respond_to(:additional_comments) }
  it { should respond_to(:delivery_company) }
  it { should respond_to(:delivery_company_contact) }

  it { should validate_presence_of :entry_date }
  it { should validate_presence_of :inventory_item }
  it { should validate_presence_of :concept }
  it { should validate_presence_of :storage_type }
  it { should validate_presence_of :delivery_company }

  it { should belong_to :inventory_item }
end
