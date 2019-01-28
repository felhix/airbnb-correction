require 'rails_helper'

RSpec.describe Reservation, type: :model do

  before(:each) do 
		@reservation = FactoryBot.create(:reservation)  	
  end

  it "has a valid factory" do
    expect(build(:reservation)).to be_valid
  end

  context "validation" do
    it "is valid with valid attributes" do
      expect(@reservation).to be_a(Reservation)
    end
    describe "start_date and end_date" do
      it "is not valid if start_date is after end_date" do
        invalid_reservation = FactoryBot.build(:reservation, start_date: Time.now, end_date: Time.now - 1.day)
        expect(invalid_reservation).not_to be_valid
        expect(invalid_reservation.errors.include?(:start_date)).to eq(true)
      end
    end
    describe "cannot create reservation if listing has already a reservation at the same time" do
      it "cannot create reservation at the same time for the same listing" do
        listing = FactoryBot.create(:listing)    
        now = Time.now
        reservation = FactoryBot.create(:reservation, listing: listing, start_date: now - 1.day, end_date: now + 2.day)
        invalid_reservation_1 = FactoryBot.build(:reservation, listing: listing, start_date: now + 1.day, end_date: now + 3.day)
        invalid_reservation_2 = FactoryBot.build(:reservation, listing: listing, start_date: now - 3.day, end_date: now)
        listing.reload
        expect(invalid_reservation_1).not_to be_valid
        expect(invalid_reservation_2).not_to be_valid
      end
    end
  end

  context "associations" do
    it { expect(@reservation).to belong_to(:listing) }
    it { expect(@reservation).to belong_to(:guest).class_name('User') }
  end

  context "public instance methods" do
    describe "#length" do
      it { expect(@reservation).to respond_to(:length) }
      it "should calculate length between start_date and end_date" do
	      reservation_1 = FactoryBot.create(:reservation, start_date: Time.now, end_date: Time.now + 3.day)
	      expect(reservation_1.length).to eq(259200)
	      reservation_2 = FactoryBot.create(:reservation, start_date: Time.now, end_date: Time.now + 2.day)
	      expect(reservation_2.length).to eq(172800)
    	end
		end
  end
end
