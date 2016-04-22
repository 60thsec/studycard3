class Card < ActiveRecord::Base
  validates :front, presence: true
  validates :back, presence: true
  belongs_to :deck

  def supermemo(rating)
    RATINGS = ['missed', 'retry', 'good', 'easy']
    q = RATINGS.index(rating)

    # Set new efactor
    self.efactor = self.efactor + (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02))
    self.efactor = 1.3 if self.efactor < 1.3

    # Set new interval

    # Set new due_date

    if rating == 'easy'
      self.update_attributes(due: Time.now + 2.days)
    elsif rating == 'good'
      self.update_attributes(due: Time.now + 1.day)
    elsif rating == 'retry'
      self.update_attributes(due: Time.now + 2.minutes)
    elsif rating == 'missed'
      self.update_attributes(due: Time.now + 2.minutes)
    end
  end

  private
    def quantify(rating)
      RATINGS = ['missed', 'retry', 'good', 'easy']
      RATINGS.index(rating)
    end
end
