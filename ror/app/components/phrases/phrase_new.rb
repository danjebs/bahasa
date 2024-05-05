# frozen_string_literal: true

class Phrases::PhraseNew < ViewComponent::Base
  def initialize(phrase:)
    @phrase = phrase
  end
end
