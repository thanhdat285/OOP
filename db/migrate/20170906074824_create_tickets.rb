class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.integer :price
      t.integer :user_buy_id
      t.string :seat
      t.references :film, foreign_key: true

      t.timestamps
    end

    # add_foreign_key :tickets, :users, column: :user_buy_id, primary_key: :id
  end
end
