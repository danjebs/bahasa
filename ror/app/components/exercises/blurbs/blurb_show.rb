# frozen_string_literal: true

class Exercises::Blurbs::BlurbShow < ViewComponent::Base
  def initialize(blurb:)
    @blurb = blurb
  end
end
