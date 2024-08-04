# frozen_string_literal: true

class Decks::DeckNew < ViewComponent::Base

  def initialize(deck:)
    @deck = deck

    @step_options = deck.journey.steps.joins(:lesson).merge(Lesson.order(position: :asc)).pluck("lessons.title", :id)
    @difficulty_options = Deck.difficulties.keys.map { |difficulty| [difficulty.humanize, difficulty] }
  end
end
