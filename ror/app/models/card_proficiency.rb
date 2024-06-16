class CardProficiency < ApplicationRecord
  belongs_to :journey
  belongs_to :card
end
