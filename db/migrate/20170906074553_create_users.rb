class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.integer :role
      t.string :email
      t.string :password
      t.string :avatar
      t.references :location, index: true, foreign_key: true

      t.timestamps
    end
  end
end
