class Card < ActiveRecord::Base
  validates :front, presence: true
  validates :back, presence: true
  belongs_to :deck

  def supermemo(rating)

    # This is a placeholder.  The real supermemo algorithm is currently in the
    #   shop undergoing repairs and upgrades.

    if rating == 'good'
      self.update_attributes(due: Time.now + 1.day)
    end
  end
end
