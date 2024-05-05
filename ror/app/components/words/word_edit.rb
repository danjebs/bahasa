# frozen_string_literal: true

class Words::WordEdit < ViewComponent::Base
  def initialize(word:)
    @word = word
  end
end
