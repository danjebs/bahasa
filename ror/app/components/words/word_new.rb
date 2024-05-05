# frozen_string_literal: true

class Words::WordNew < ViewComponent::Base
  def initialize(exercise_word:)
    @word = exercise_word
  end
end
