# frozen_string_literal: true

class UI::Layout::Breadcrumbs < ViewComponent::Base
  def initialize(breadcrumbs: [])
    @breadcrumbs = breadcrumbs || []
  end

  def render?
    @breadcrumbs.present?
  end
end
