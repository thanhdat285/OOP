class CreateFilms < ActiveRecord::Migration[5.1]
  def change
    create_table :films do |t|
      t.string :name
      t.references :room, foreign_key: true
      t.datetime :time_begin
      t.datetime :time_end
      t.integer :user_sell_id

      t.timestamps
    end

    # add_foreign_key :films, :users, column: :user_sell_id, primary_key: :id
  end
end
