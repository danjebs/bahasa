# frozen_string_literal: true

class Cards::Translations::TranslationCardNew < ViewComponent::Base
  def initialize(lesson_id:)
    @translation_card = TranslationCard.new(lesson_id: lesson_id)
  end
end
