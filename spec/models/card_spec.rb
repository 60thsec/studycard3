require 'rails_helper'

RSpec.describe Card, type: :model do
  it "accepts valid input" do
    expect(FactoryGirl.build(:card)).to be_valid
  end

  it "is invalid without a front" do
    expect(FactoryGirl.build(:card, front: nil)).to_not be_valid
  end

  it "is invalid without a back" do
    expect(FactoryGirl.build(:card, back: nil)).to_not be_valid
  end

end
