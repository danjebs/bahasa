class CardProficiency < ApplicationRecord
  belongs_to :journey
  belongs_to :deck_card

  delegates :card, to: deck_card
end
