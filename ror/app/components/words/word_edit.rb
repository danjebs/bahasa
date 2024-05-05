# frozen_string_literal: true

class Words::WordEdit < ViewComponent::Base
  def initialize(exercise_word:)
    @word = exercise_word
  end
end
