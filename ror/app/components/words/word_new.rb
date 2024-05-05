# frozen_string_literal: true

class Words::WordNew < ViewComponent::Base
  def initialize(word:)
    @word = word
  end
end
