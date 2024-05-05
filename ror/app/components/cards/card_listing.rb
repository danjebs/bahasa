# frozen_string_literal: true

class Cards::CardListing < ViewComponent::Base
  with_collection_parameter :card

  def initialize(card:)
    @card = card
  end
end
