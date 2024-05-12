# frozen_string_literal: true

class Journeys::JourneyShow < ViewComponent::Base
  def initialize(journey:)
    @journey = journey
  end

  def continue_path
    if @journey.next_lesson.present?
      @journey.next_lesson
    else
      new_lesson_path
    end
  end
end
