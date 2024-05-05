# frozen_string_literal: true

class Phrases::PhraseEdit < ViewComponent::Base
  def initialize(phrase:)
    @phrase = phrase
  end
end
