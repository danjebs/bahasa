# frozen_string_literal: true

class Cards::Translations::TranslationCardForm < ViewComponent::Base
  def initialize(translation_card:)
    @translation_card = translation_card
  end
end
