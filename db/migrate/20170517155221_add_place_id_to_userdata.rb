class AddPlaceIdToUserdata < ActiveRecord::Migration[5.0]
  def change
    add_column :userdata, :place_id, :string
  end
end
