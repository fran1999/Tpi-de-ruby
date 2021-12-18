class Professional < ApplicationRecord
    has_many :appointments
    validates :name, :surname, presence: true, uniqueness: true
end
