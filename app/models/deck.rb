class Deck < ActiveRecord::Base
  belongs_to :user
  has_many   :cards, dependent: :destroy
  validates  :title, presence: true

  def get_next_card
    cards.where(["due < ?", Time.now]).reload.order(:due).last || Card.new 
  end
end
