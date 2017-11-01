class CreateSchedules < ActiveRecord::Migration[5.1]
  def change
    create_table :schedules do |t|
      t.references :film, foreign_key: true
      t.references :location, foreign_key: true
      t.datetime :time_begin
      t.datetime :time_end
      t.references :user_sell, index: true, foreign_key: {to_table: :users}
      t.timestamps
    end

    # add_foreign_key :films, :users, column: :user_sell_id, primary_key: :id
  end
end
