class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      
      t.string :name_patient, null: false
      t.string :surname_patient, null: false
      t.datetime :date, null: false
      t.string :phone, 
      t.string :notes, null: true
      t.belongs_to :professional, null: false, foreign_key: true

      t.timestamps
    end
  end
end
