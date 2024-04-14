class WordlistExercise < Exercise
  belongs_to :wordlist, optional: true

  # has_many words, through: :wordlist

  after_create :ensure_wordlist_is_set

  def ensure_wordlist_is_set
    self.update(wordlist: Wordlist.create(name: self.title, language: self.lesson.language))
  end
end
