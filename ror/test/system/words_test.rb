require "application_system_test_case"

class WordsTest < ApplicationSystemTestCase
  setup do
    @word = words(:one)
  end

  test "visiting the index" do
    visit words_url
    assert_selector "h1", text: "Exercise words"
  end

  test "should create exercise word" do
    visit words_url
    click_on "New exercise word"

    fill_in "Exercise", with: @word.exercise_id
    fill_in "Position", with: @word.position
    fill_in "Translation", with: @word.translation
    fill_in "Word", with: @word.word
    click_on "Create Exercise word"

    assert_text "Exercise word was successfully created"
    click_on "Back"
  end

  test "should update Exercise word" do
    visit word_url(@word)
    click_on "Edit this exercise word", match: :first

    fill_in "Exercise", with: @word.exercise_id
    fill_in "Position", with: @word.position
    fill_in "Translation", with: @word.translation
    fill_in "Word", with: @word.word
    click_on "Update Exercise word"

    assert_text "Exercise word was successfully updated"
    click_on "Back"
  end

  test "should destroy Exercise word" do
    visit word_url(@word)
    click_on "Destroy this exercise word", match: :first

    assert_text "Exercise word was successfully destroyed"
  end
end
