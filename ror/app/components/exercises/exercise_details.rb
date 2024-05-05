# frozen_string_literal: true

class Exercises::ExerciseDetails < ViewComponent::Base
  with_collection_parameter :exercise

  def initialize(exercise:)
    @exercise = exercise
  end
end
