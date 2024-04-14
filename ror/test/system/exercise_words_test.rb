require "application_system_test_case"

class ExerciseWordsTest < ApplicationSystemTestCase
  setup do
    @exercise_word = exercise_words(:one)
  end

  test "visiting the index" do
    visit exercise_words_url
    assert_selector "h1", text: "Exercise words"
  end

  test "should create exercise word" do
    visit exercise_words_url
    click_on "New exercise word"

    fill_in "Exercise", with: @exercise_word.exercise_id
    fill_in "Position", with: @exercise_word.position
    fill_in "Translation", with: @exercise_word.translation
    fill_in "Word", with: @exercise_word.word
    click_on "Create Exercise word"

    assert_text "Exercise word was successfully created"
    click_on "Back"
  end

  test "should update Exercise word" do
    visit exercise_word_url(@exercise_word)
    click_on "Edit this exercise word", match: :first

    fill_in "Exercise", with: @exercise_word.exercise_id
    fill_in "Position", with: @exercise_word.position
    fill_in "Translation", with: @exercise_word.translation
    fill_in "Word", with: @exercise_word.word
    click_on "Update Exercise word"

    assert_text "Exercise word was successfully updated"
    click_on "Back"
  end

  test "should destroy Exercise word" do
    visit exercise_word_url(@exercise_word)
    click_on "Destroy this exercise word", match: :first

    assert_text "Exercise word was successfully destroyed"
  end
end
