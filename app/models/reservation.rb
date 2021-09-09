class Reservation < ApplicationRecord
  belongs_to :guest

  validates :code, presence: true, uniqueness: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :total_amount, presence: true, numericality: { greater_than: 0}
  validates :payout_amount, presence: true, numericality: { greater_than: 0}
  validates :currency, presence: true
  validates :security_price, presence: true, numericality: { greater_than: 0}
  validates :status, presence: true
  validates :number_of_nights, presence: true, numericality: { only_integer: true, greater_than: 0}
  validates :number_of_adults, presence: true, numericality: { only_integer: true, greater_than: 0}
  validates :number_of_children, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}
  validates :number_of_infants, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0}
  validates :number_of_guests, presence: true, numericality: { only_integer: true, greater_than: 0}
end
