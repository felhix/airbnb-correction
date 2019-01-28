require 'rails_helper'

RSpec.describe Listing, type: :model do

  before(:each) do 
		@listing = FactoryBot.create(:listing)  	
  end

  it "has a valid factory" do
    expect(build(:listing)).to be_valid
  end

  context "validation" do
    it "is valid with valid attributes" do
      expect(@listing).to be_a(Listing)
    end
    describe "#available_beds" do
      it { expect(@listing).to validate_presence_of(:available_beds) }
      it { expect(@listing).to validate_numericality_of(:available_beds).is_greater_than(0) }
		end
    describe "#price" do
      it { expect(@listing).to validate_presence_of(:price) }
      it { expect(@listing).to validate_numericality_of(:price).is_greater_than(0) }
		end
    describe "#description" do
      it { expect(@listing).to validate_presence_of(:description) }
      it { expect(@listing).to validate_length_of(:description).is_at_least(140) }
		end
    describe "#welcome_message" do
      it { expect(@listing).to validate_presence_of(:welcome_message) }
		end
	end

  context "associations" do
    it { expect(@listing).to have_many(:reservations) }
    it { expect(@listing).to belong_to(:city) }
    it { expect(@listing).to belong_to(:admin).class_name('User') }
  end

  context "public instance methods" do
    describe "#overlaping_reservation" do
      it { expect(@listing).to respond_to(:overlaping_reservation?) }
      it "should tell if the listing is taken at this date" do
        now = Time.now
        listing = FactoryBot.create(:listing)    
        reservation_1 = FactoryBot.create(:reservation, listing: listing, start_date: now - 1.day, end_date: now + 1.day)
        reservation_2 = FactoryBot.create(:reservation, listing: listing, start_date: now + 2.day, end_date: now + 4.day)
        listing.reload
        expect(listing.overlaping_reservation?(now)).to eq(true)
        expect(listing.overlaping_reservation?(now - 2.day)).to eq(false)
        expect(listing.overlaping_reservation?(now + 3.day)).to eq(true)
      end
    end
  end


end
