require "test_helper"

class JourneysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student = users(:simba)
    @teacher = users(:teacher_id)

    @other_student = users(:bean)
    @other_teacher = users(:teacher_de)

    sign_in @student
  end

  test "should get index for student" do
    get journeys_url
    assert_response :success
    @student.journeys.each do |journey|
      assert_select "div##{dom_id(journey, :row)}"
    end
    @other_student.journeys.each do |journey|
      assert_select "div##{dom_id(journey, :row)}", count: 0
    end
    @student.languages_without_journeys.each do |language|
      assert_select "a[href=?]", create_journey_url(language_id: language.id)
    end
  end

  test "should get index for teacher" do
    sign_in @teacher
    get journeys_url
    assert_response :success
    (@teacher.journeys + @teacher.students.journeys).each do |journey|
      assert_select "div##{dom_id(journey, :row)}"
    end
    @other_teacher.journeys.each do |journey|
      assert_select "div##{dom_id(journey, :row)}", count: 0
    end
  end

  test "should get show for student with access" do
    journey = @student.journeys.first
    get journey_url(journey)
    assert_response :success
  end

  test "should get show for teacher with access" do
    sign_in @teacher
    journey = @teacher.students.first.journeys.first
    get journey_url(journey)
    assert_response :success
  end

  test "should not get show for student without access" do
    journey = @other_student.journeys.first
    get journey_url(journey)
    assert_redirected_to root_url
  end

  test "should not get show for teacher without access" do
    sign_in @teacher
    journey = @other_teacher.journeys.first
    get journey_url(journey)
    assert_redirected_to root_url
  end

  test "should get create if student has no existing journey" do
    sign_in @student
    assert_difference("Journey.count", 1) do
      post journeys_url, params: {
        journey: { language_id: languages(:ta).id }
      }
    end
    assert_redirected_to journey_url(Journey.last)
  end

  test "should not get create if student has an existing journey" do
    sign_in @student
    post journeys_url, params: {
      journey: { language_id: @student.journeys.first.language_id }
    }
    assert_no_difference("Journey.count")
    assert_redirected_to root_url
  end

  test "should not access edit" do
    assert_raises(ActionController::RoutingError) do
      get edit_journey_url(id: 1)
    end
  end

  test "should not access patch" do
    assert_raises(ActionController::RoutingError) do
      patch journey_url(id: 1)
    end
  end

  test "should not access delete" do
    first_journey = journeys(:simba_language_id)
    assert_raises(ActionController::RoutingError) do
      delete journey_url(id: 1, lang: Journey.find(1).language.code)
    end
  end

  test "should handle student with no journeys" do
    sign_in @other_student
    get journeys_url
    assert_response :success
    assert_select "div[id^='row_journey_']", count: 0
    assert_select "a[href=?]", create_journey_url(language_id: languages(:new_language).id)
  end

  test "should handle teacher with no students" do
    teacher_without_students = users(:teacher_without_students)
    sign_in teacher_without_students
    get journeys_url
    assert_response :success
    teacher_without_students.journeys.each do |journey|
      assert_select "div##{dom_id(journey, :row)}"
    end
  end

  test "should handle invalid journey creation" do
    sign_in @student
    assert_no_difference("Journey.count") do
      post journeys_url, params: { journey: { language_id: nil } }
    end
    assert_response :unprocessable_entity
  end

  test "should handle non-existent journey access" do
    get journey_url(id: -1)
    assert_redirected_to root_url
  end
end
