class ChangeVideoOwner < ActiveRecord::Migration
  def change
    add_column :spree_videos, :owner_id, :integer
    add_column :spree_videos, :owner_type, :string
    add_index :spree_videos, :owner_id
    add_index :spree_videos, :owner_type

    execute(<<-SQL)
      UPDATE spree_videos SET owner_id = product_id
                              owner_type = 'Spree::Product';
    SQL

    remove_column :spree_videos, :product_id
  end
end
