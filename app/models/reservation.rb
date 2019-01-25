class Reservation < ApplicationRecord
  belongs_to :listing
  belongs_to :guest, class_name: "User"
  validate :start_date_must_be_before_end_date

  def length
  	self.end_date.to_i - self.start_date.to_i
  end


  private

	def start_date_must_be_before_end_date
	  return unless start_date and end_date
	  errors.add(:start_date, "must be before end date") unless start_date < end_date
	end

end