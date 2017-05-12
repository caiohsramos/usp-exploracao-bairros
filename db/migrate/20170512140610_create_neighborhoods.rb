class CreateNeighborhoods < ActiveRecord::Migration[5.0]
    def change
        create_table :neighborhoods do |t|
            t.string :name, :default => ""
            t.float :lat, :default => nil
            t.float :lon, :default => nil

            t.timestamps
        end
    end
end