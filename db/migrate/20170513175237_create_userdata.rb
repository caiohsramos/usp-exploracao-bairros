class CreateUserdata < ActiveRecord::Migration[5.0]
  def change
    create_table :userdata do |t|
      t.string :name
      t.string :comment

      t.timestamps
    end
  end
end
