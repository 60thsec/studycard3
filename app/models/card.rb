class Card < ActiveRecord::Base
  validates :front, presence: true
  validates :back, presence: true
  belongs_to :deck

  def supermemo(rating)
    # TODO
  end
end
