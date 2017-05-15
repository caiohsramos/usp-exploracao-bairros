class AddUserIdToUserdata < ActiveRecord::Migration[5.0]
  def change
    add_column :userdata, :user_id, :integer
  end
end
