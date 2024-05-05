# frozen_string_literal: true

class Words::WordForm < ViewComponent::Base
  def initialize(exercise_word:)
    @word = exercise_word
  end
end
