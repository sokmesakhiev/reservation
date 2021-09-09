class Guest < ApplicationRecord
  has_many :reservations

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone, presence: true
end
