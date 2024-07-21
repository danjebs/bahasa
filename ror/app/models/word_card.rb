class WordCard < Card
  validates :front, presence: true

  def max_scoring_time
    3
  end
end
