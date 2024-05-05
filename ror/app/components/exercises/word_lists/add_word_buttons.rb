# frozen_string_literal: true

class Exercises::WordLists::AddWordButtons < ViewComponent::Base
  def initialize(word_list:)
    @word_list = word_list
  end
end

