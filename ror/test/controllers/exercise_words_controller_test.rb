require "test_helper"

class ExerciseWordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exercise_word = exercise_words(:one)
  end

  test "should get index" do
    get exercise_words_url
    assert_response :success
  end

  test "should get new" do
    get new_exercise_word_url
    assert_response :success
  end

  test "should create exercise_word" do
    assert_difference("ExerciseWord.count") do
      post exercise_words_url, params: { exercise_word: { exercise_id: @exercise_word.exercise_id, position: @exercise_word.position, translation: @exercise_word.translation, word: @exercise_word.word } }
    end

    assert_redirected_to exercise_word_url(ExerciseWord.last)
  end

  test "should show exercise_word" do
    get exercise_word_url(@exercise_word)
    assert_response :success
  end

  test "should get edit" do
    get edit_exercise_word_url(@exercise_word)
    assert_response :success
  end

  test "should update exercise_word" do
    patch exercise_word_url(@exercise_word), params: { exercise_word: { exercise_id: @exercise_word.exercise_id, position: @exercise_word.position, translation: @exercise_word.translation, word: @exercise_word.word } }
    assert_redirected_to exercise_word_url(@exercise_word)
  end

  test "should destroy exercise_word" do
    assert_difference("ExerciseWord.count", -1) do
      delete exercise_word_url(@exercise_word)
    end

    assert_redirected_to exercise_words_url
  end
end
