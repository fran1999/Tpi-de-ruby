class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      
      t.string :name_patient
      t.string :surname_patient
      t.datetime :date
      t.string :phone
      t.string :notes

      t.timestamps
    end
  end
end
