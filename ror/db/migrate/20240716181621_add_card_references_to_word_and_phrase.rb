class AddCardReferencesToWordAndPhrase < ActiveRecord::Migration[7.1]
  def change
    add_reference :cards, :cardable, polymorphic: true

    Word.all.each do |word|
      WordCard.create(
        front: word.word,
        back: word.translation,
        lesson_id: word.exercise.lesson_id,
        cardable_type: 'Word',
        cardable_id: word.id,
      )
    end

    Phrase.all.each do |phrase|
      PhraseCard.create(
        front: phrase.phrase,
        back: phrase.translation,
        lesson_id: phrase.exercise.lesson_id,
        cardable_type: 'Phrase',
        cardable_id: phrase.id,
      )
    end
  end
end
