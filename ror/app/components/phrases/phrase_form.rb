# frozen_string_literal: true

class Phrases::PhraseForm < ViewComponent::Base
  def initialize(phrase:)
    @phrase = phrase
  end
end
