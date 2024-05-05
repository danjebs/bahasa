# frozen_string_literal: true

class Phrases::PhraseListing < ViewComponent::Base
  with_collection_parameter :phrase

  def initialize(phrase:)
    @phrase = phrase
  end
end
