module Transactionable

  def log_transaction entry_date, inventory_item_id, concept, storage_type, estimated_issue_date, additional_comments, delivery_company, delivery_company_contact

    inv_tran = InventoryTransaction.new(:entry_date => entry_date, :inventory_item_id => inventory_item_id, :concept => concept, :storage_type => storage_type, :estimated_issue_date => estimated_issue_date, :additional_comments => additional_comments, :delivery_company => delivery_company, :delivery_company_contact => delivery_company_contact)

    return inv_tran.save!

  end  
  
end