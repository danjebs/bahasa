require "test_helper"

class PhrasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @phrase = phrases(:intro_self)
  end

  test "should get index" do
    get phrases_url
    assert_response :success
  end

  test "should get new" do
    get new_phrase_url
    assert_response :success
  end

  test "should create phrase" do
    assert_difference("Word.count") do
      post phrases_url, params: { phrase: { exercise_id: @phrase.exercise_id, position: @phrase.position, translation: @phrase.translation, phrase: @phrase.phrase } }
    end

    assert_redirected_to phrase_url(Word.last)
  end

  test "should show phrase" do
    get phrase_url(@phrase)
    assert_response :success
  end

  test "should get edit" do
    get edit_phrase_url(@phrase)
    assert_response :success
  end

  test "should update phrase" do
    patch phrase_url(@phrase), params: { phrase: { exercise_id: @phrase.exercise_id, position: @phrase.position, translation: @phrase.translation, phrase: @phrase.phrase } }
    assert_redirected_to phrase_url(@phrase)
  end

  test "should destroy phrase" do
    assert_difference("Word.count", -1) do
      delete phrase_url(@phrase)
    end

    assert_redirected_to phrases_url
  end
end
