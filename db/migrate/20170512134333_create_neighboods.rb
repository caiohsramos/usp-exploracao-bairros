class CreateNeighboods < ActiveRecord::Migration[5.0]
  def change
    create_table :neighboods do |t|

      t.timestamps
    end
  end
end
