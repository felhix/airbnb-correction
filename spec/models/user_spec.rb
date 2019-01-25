require 'rails_helper'

RSpec.describe User, type: :model do

  before(:each) do 
		@user = FactoryBot.create(:user)  	
  end

  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  context "validation" do
    it "is valid with valid attributes" do
      expect(@user).to be_a(User)
    end
    describe "#email" do
      it { expect(@user).to validate_presence_of(:email) }
      it { expect(@user).to validate_uniqueness_of(:email) }
      it { is_expected.to allow_value("email@addresse.foo").for(:email) }
      it { is_expected.to_not allow_value("foo").for(:email) }
      it { is_expected.to_not allow_value("jean@examplecom").for(:email) }
		end
		describe "#phone_number" do
		  it { expect(@user).to validate_presence_of(:phone_number) }
      it { is_expected.to allow_value("0123456789").for(:phone_number) }
      it { is_expected.to allow_value("01 23 45 67 89").for(:phone_number) }
      it { is_expected.to allow_value("01.23.45.67.89").for(:phone_number) }
      it { is_expected.to allow_value("0123 45.67.89").for(:phone_number) }
      it { is_expected.to allow_value("0033 123-456-789").for(:phone_number) }
      it { is_expected.to allow_value("+33-1.23.45.67.89").for(:phone_number) }
      it { is_expected.to allow_value("+33 - 123 456 789").for(:phone_number) }
      it { is_expected.to allow_value("+33(0) 123 456 789").for(:phone_number) }
      it { is_expected.to allow_value("+33 (0)123 45 67 89").for(:phone_number) }
      it { is_expected.to allow_value("+33 (0)1 2345-6789").for(:phone_number) }
      it { is_expected.to allow_value("+33(0) - 123456789").for(:phone_number) }
      it { is_expected.to_not allow_value("foo").for(:phone_number) }
      it { is_expected.to_not allow_value("jean@examplecom").for(:phone_number) }
	  end
  end

  context "associations" do
    it { expect(@user).to have_many(:reservations).with_foreign_key(:guest_id) }
    it { expect(@user).to have_many(:listings).with_foreign_key(:admin_id) }
  end

end