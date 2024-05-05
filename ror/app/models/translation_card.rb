class TranslationCard < Card
  validates :back, presence: true, uniqueness: { scope: :lesson_id }
end
