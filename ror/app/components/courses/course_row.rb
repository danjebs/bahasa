# frozen_string_literal: true

class Courses::CourseRow < ViewComponent::Base
  def initialize(course:)
    @course = course
  end
end
