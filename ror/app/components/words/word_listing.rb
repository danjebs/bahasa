# frozen_string_literal: true

class Words::WordListing < ViewComponent::Base
  with_collection_parameter :word

  def initialize(word:)
    @word = word
  end
end
