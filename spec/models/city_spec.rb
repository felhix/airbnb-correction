require 'rails_helper'

RSpec.describe City, type: :model do

  before(:each) do 
		@city = FactoryBot.create(:city)  	
  end

  it "has a valid factory" do
    expect(build(:city)).to be_valid
  end

  context "validation" do
    it "is valid with valid attributes" do
      expect(@city).to be_a(City)
    end
    describe "#name" do
      it { expect(@city).to validate_presence_of(:name) }
		end
		describe "#zip_code" do
		  it { expect(@city).to validate_presence_of(:zip_code) }
      it { expect(@city).to validate_uniqueness_of(:zip_code).case_insensitive }
      it { is_expected.to allow_value("33800").for(:zip_code) }
      it { is_expected.to allow_value("05123").for(:zip_code) }
      it { is_expected.to allow_value("2a004").for(:zip_code) }
      it { is_expected.to allow_value("2A004").for(:zip_code) }
      it { is_expected.to allow_value("95600").for(:zip_code) }
      it { is_expected.to_not allow_value("100000").for(:zip_code) }
      it { is_expected.to_not allow_value("0000").for(:zip_code) }
	  end
  end

  context "associations" do
    it { expect(@city).to have_many(:listings) }
  end

end
