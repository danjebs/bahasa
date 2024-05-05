# frozen_string_literal: true

class Exercises::Blurbs::BlurbDetails < ViewComponent::Base
  def initialize(blurb:)
    @blurb = blurb
  end
end
