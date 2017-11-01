class CreateFilmRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :film_rooms do |t|
      t.references :film, foreign_key: true
      t.references :location, foreign_key: true
      t.datetime :time_begin
      t.datetime :time_end
      t.integer :user_sell_id
      t.timestamps
    end

    # add_foreign_key :films, :users, column: :user_sell_id, primary_key: :id
  end
end
