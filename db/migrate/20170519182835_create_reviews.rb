class CreateReviews < ActiveRecord::Migration[5.0]
  def change
        create_table :reviews do |t|
            t.integer :user_id
            t.string :place_id
            t.text :comment
            t.integer :rate
            
            t.timestamps
        end
  end
end
