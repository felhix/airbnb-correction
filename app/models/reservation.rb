class Reservation < ApplicationRecord
  validates_with ReservationValidator, on: :create
  belongs_to :listing
  belongs_to :guest, class_name: "User"

  def length
  	self.end_date.to_i - self.start_date.to_i
  end

  private

  def has_the_listing_a_reservation_at_the_same_date?
    return unless listing
    listing_already_taken = false
    listing_already_taken = true if listing.overlaping_reservation?(start_date) || listing.overlaping_reservation?(end_date)
    errors.add(:listing, "has already a reservation at the same time") if listing_already_taken
  end

end