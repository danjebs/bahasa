# frozen_string_literal: true

class Exercises::Wordlists::WordlistDetails < ViewComponent::Base
  def initialize(wordlist_exercise:)
    @wordlist_exercise = wordlist_exercise
  end
end
