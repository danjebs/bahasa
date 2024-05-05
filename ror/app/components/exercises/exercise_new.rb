# frozen_string_literal: true

class Exercises::ExerciseNew < ViewComponent::Base

  def initialize(exercise:)
    @exercise = exercise
  end
end
