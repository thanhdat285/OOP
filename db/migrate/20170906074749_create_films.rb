class CreateFilms < ActiveRecord::Migration[5.1]
  def change
    create_table :films do |t|
      t.string :name
      t.string :image
      t.string :kind
      t.string :duration
      t.text :content
      t.date :release_date

      t.timestamps
    end

    # add_foreign_key :films, :users, column: :user_sell_id, primary_key: :id
  end
end
