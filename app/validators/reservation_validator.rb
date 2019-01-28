class ReservationValidator < ActiveModel::Validator

  def validate(record)
  	start_date_must_be_before_end_date(record)
    no_overlaping_reservations(record)
  end

  private

  def start_date_must_be_before_end_date(record)
	  return unless record.start_date and record.end_date
    record.errors[:start_date] << "must be before end date" unless record.start_date < record.end_date
  end

  def no_overlaping_reservations(record)
  	listing = record.listing
    return unless listing
    listing_already_taken = false
    listing_already_taken = true if listing.overlaping_reservation?(record.start_date) || listing.overlaping_reservation?(record.end_date)
    record.errors[:listing] << "has already a reservation at the same time" if listing_already_taken
  end

end

