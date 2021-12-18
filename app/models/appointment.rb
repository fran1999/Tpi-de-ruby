class Appointment < ApplicationRecord
    belongs_to :professional
    validates :name_patiente, :surname_patient, :phone, :date, presence: true
end
