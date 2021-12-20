class Appointment < ApplicationRecord
  belongs_to :professional
  validates :patient_name, :patient_surname, :date, :phone, presence: true
  validates :phone, numericality: { only_integer: true }
  validate :hour_valid, :hour_without_reservation

  def hour_valid
    if not date.blank?
      if not [0,30].include? date.min
        errors.add(:date, "Los minutos deben en punto o y media ")
      end
      if not (9..19).include? date.hour
        errors.add(:date, "Los horarios diponible son entre las 9 y las 19 horas") 
      end
    end
  end

  
  def hour_without_reservation
    if not date.blank?
      appointment = Appointment.where("date = ? and professional_id = ?", date.to_datetime, professional_id).first
      if appointment
        errors.add(:date, "EL horario con ese professional ya esta ocupado") unless id == appointment.id
      end
    end
  end
  
  def schedule_format()
    "Prof. #{professional.name} - #{patient_surname} #{patient_name}"
  end
end
