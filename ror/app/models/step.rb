class Step < ApplicationRecord
  belongs_to :journey
  belongs_to :lesson

  enum :status, {
    created: "created",
    started: "started",
    completed: "completed"
  }, prefix: :status_is

  after_initialize :init

  def init
    self.status ||= :created
  end
end
