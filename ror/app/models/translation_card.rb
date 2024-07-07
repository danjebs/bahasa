class TranslationCard < Card
  validates :front, presence: true, uniqueness: { scope: :lesson_id }
end
