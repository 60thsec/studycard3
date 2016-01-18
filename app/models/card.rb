class Card < ActiveRecord::Base
  validates :front, presence: true
  validates :back, presence: true
  belongs_to :deck

  def supermemo(rating)
    self.update_attributes(due: Time.now + 1.day)
  end
end
