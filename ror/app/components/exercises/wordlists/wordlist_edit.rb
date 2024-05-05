# frozen_string_literal: true

class Exercises::Wordlists::WordlistEdit < ViewComponent::Base
  def initialize(wordlist:)
    @wordlist = wordlist
  end
end
