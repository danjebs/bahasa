# frozen_string_literal: true

class Words::WordListing < ViewComponent::Base
  with_collection_parameter :exercise_word

  def initialize(exercise_word:)
    @word = exercise_word
  end
end
