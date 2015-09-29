class AddImageUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :image_url, :string, :default => 'default_user.png'
  end
end
