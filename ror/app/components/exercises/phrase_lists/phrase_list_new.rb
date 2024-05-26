# frozen_string_literal: true

class Exercises::PhraseLists::PhraseListNew < ViewComponent::Base
  def initialize(phrase_list:)
    @phrase_list = phrase_list
  end
end
