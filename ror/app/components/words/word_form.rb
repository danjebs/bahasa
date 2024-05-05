# frozen_string_literal: true

class Words::WordForm < ViewComponent::Base
  def initialize(word:)
    @word = word
  end
end
