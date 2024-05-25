# frozen_string_literal: true

class Exercises::ExerciseShow < ViewComponent::Base
  def initialize(exercise:)
    @exercise = exercise
  end
end
