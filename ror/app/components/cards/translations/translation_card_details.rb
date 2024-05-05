# frozen_string_literal: true

class Cards::Translations::TranslationCardDetails < ViewComponent::Base
  def initialize(translation_card:)
    @translation_card = translation_card
  end
end
