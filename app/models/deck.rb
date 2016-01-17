class Deck < ActiveRecord::Base
  belongs_to :user
  has_many   :cards, dependent: :destroy
  validates  :title, presence: true

  def get_next_card
    cards.where(["due < ?", Time.now]).order(:due).first
  end
end
