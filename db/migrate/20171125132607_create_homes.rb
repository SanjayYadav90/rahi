class CreateHomes < ActiveRecord::Migration[5.1]
  def change
    create_table :homes do |t|
      t.integer :user_id
      t.text :current_location
      t.text :destination_location

      t.timestamps
    end
  end
end
