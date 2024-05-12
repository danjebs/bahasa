# frozen_string_literal: true

class Journeys::JourneyListing < ViewComponent::Base
  def initialize(journeys:, languages_to_learn:)
    @journeys = journeys
    @languages_to_learn = languages_to_learn
  end
end
