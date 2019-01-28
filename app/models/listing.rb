class Listing < ApplicationRecord
  has_many :reservations
  belongs_to :city
  belongs_to :admin, class_name: "User"

  validates :available_beds, 
    presence: true,
    numericality: { greater_than: 0 }

  validates :price, 
    presence: true,
    numericality: { greater_than: 0 }

  validates :description, 
    presence: true,
    length: { minimum: 140 }

  validates :welcome_message, presence: true


  def overlaping_reservation?(datetime)
    overlaping_reservation = false
    self.reservations.each do |reservation|
      overlaping_reservation = true if reservation.start_date < datetime and reservation.end_date > datetime 
    end
    overlaping_reservation
  end

  def future_reservations
    self.reservations.where("start_date > ?", Time.now).order(:start_date)
  end

end
