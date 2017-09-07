class CreateRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :rooms do |t|
      t.json :seats

      t.timestamps
    end
  end
end
