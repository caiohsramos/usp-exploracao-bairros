class CreateNeighboods < ActiveRecord::Migration[5.0]
    def change
        create_table :neighboods do |t|
            t.string :name, :default => ""
            t.float :lat, :default => nil
            t.float :lon, :default => nil
            
            t.timestamps
        end
    end
end
