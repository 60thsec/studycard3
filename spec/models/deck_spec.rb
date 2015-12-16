require 'rails_helper'

RSpec.describe Deck, type: :model do
  it "accepts valid inputs" do
    expect(FactoryGirl.build(:deck)).to be_valid
  end

  it "is invalid without a title" do
    expect(FactoryGirl.build(:deck, title: nil)).to_not be_valid
  end
end
