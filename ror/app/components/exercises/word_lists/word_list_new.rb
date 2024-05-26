# frozen_string_literal: true

class Exercises::WordLists::WordListNew < ViewComponent::Base
  def initialize(word_list:)
    @word_list = word_list
  end
end
