class CreateObfuscates < ActiveRecord::Migration[5.0]
  def change
    create_table :obfuscates do |t|

      t.timestamps
    end
  end
end
