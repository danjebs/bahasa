# frozen_string_literal: true

class Exercises::Blurbs::BlurbNew < ViewComponent::Base
  delegate :rich_text_area_tag, to: :helpers

  def initialize(blurb:)
    @blurb = blurb
  end
end
