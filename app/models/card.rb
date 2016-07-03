class Card < ActiveRecord::Base
  validates :front, presence: true
  validates :back, presence: true
  belongs_to :deck

  def supermemo(rating)
    q = rating.to_i

    self.efactor = 2.5 unless self.efactor
    self.repetition = 0 unless self.repetition

    self.set_efactor(q)
    self.set_interval
    self.set_due(q)

    self.save
  end

  def set_efactor(q)
    if q < 3
      self.repetition = 1
    else
      self.efactor = self.efactor + (0.1 - (5 - q) * (0.08 + (5 - q) * 0.02))
      self.efactor = 1.3 if self.efactor < 1.3

      self.repetition += 1
    end
  end

  def set_due(q)
    if q < 3
      self.due = Time.now + rand(2..4).minutes
    else
      self.due = Time.now + interval.days
    end
  end

  def set_interval
    if self.repetition == 1
      self.interval = 1
    elsif self.repetition == 2
      self.interval = 6
    else
      self.interval = (self.interval * self.efactor).floor
    end
  end

  private
    def quantify(rating)
      ratings = ['missed', '', 'retry', '', 'good', 'easy']
      ratings.index(rating)
    end
end
