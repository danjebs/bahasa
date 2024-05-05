# frozen_string_literal: true

class Lessons::AddCardButtons < ViewComponent::Base
  def initialize(lesson:)
    @lesson = lesson
  end
end
