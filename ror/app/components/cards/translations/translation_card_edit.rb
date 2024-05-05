# frozen_string_literal: true

class Cards::Translations::TranslationCardEdit < ViewComponent::Base
  def initialize(translation_card:)
    @translation_card = translation_card
  end
end
