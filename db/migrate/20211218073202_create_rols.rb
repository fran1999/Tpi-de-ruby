class CreateRols < ActiveRecord::Migration[6.1]
  def change
    create_table :rols do |t|
      t.string :name

      t.timestamps
    end
    add_index :rols, :name, unique: true
  end
end
