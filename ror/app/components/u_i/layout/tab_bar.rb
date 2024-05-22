# frozen_string_literal: true

class UI::Layout::TabBar < ViewComponent::Base
  renders_many :sections

  def initialize(tabs: [])
    @tabs = tabs
  end
end
