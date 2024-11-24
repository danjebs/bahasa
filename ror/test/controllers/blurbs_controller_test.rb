require "test_helper"

class BlurbsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student = users(:student_id_ta)
    @teacher = users(:teacher_id_one)

    @other_student = users(:student_id)
    @other_teacher = users(:teacher_id_two)

    @blurb = exercises(:blurb_lesson_greetings_id)

    sign_in @student
  end

  test "should get new for student with existing journey" do
    get new_blurb_url(lang: @blurb.language.code)
    assert_response :success
  end

  test "should not get new for student without existing journey" do
    sign_in @other_student
    get new_blurb_url(lang: @blurb.language.code)
    assert_redirected_to root_url
  end

  test "should show blurb for student with access" do
    get blurb_url(@blurb, lang: @blurb.language.code)
    assert_response :success
  end

  test "should show blurb for teacher with access" do
    sign_in @teacher
    get blurb_url(@blurb, lang: @blurb.language.code)
    assert_response :success
  end

  test "should not show blurb for student without access" do
    sign_in @other_student
    get blurb_url(@blurb, lang: @blurb.language.code)
    assert_redirected_to root_url
  end

  test "should not show blurb for teacher without access" do
    sign_in @other_teacher
    get blurb_url(@blurb, lang: @blurb.language.code)
    assert_redirected_to root_url
  end

  test "should create blurb if student has access" do
    assert_difference('Blurb.count') do
      post blurbs_url(lang: @blurb.language.code), params: { blurb: { title: "New Blurb", content: "Content" } }
    end
    assert_redirected_to blurb_url(Blurb.last, lang: @blurb.language.code)
  end

  test "should update blurb if student has access" do
    patch blurb_url(@blurb, lang: @blurb.language.code), params: { blurb: { title: "Updated Title" } }
    assert_redirected_to blurb_url(@blurb, lang: @blurb.language.code)
    @blurb.reload
    assert_equal "Updated Title", @blurb.title
  end

  test "should not destroy blurb for student with access" do
    assert_no_difference('Blurb.count') do
      delete blurb_url(@blurb, lang: @blurb.language.code)
    end
    assert_redirected_to root_url
  end

  test "should handle invalid blurb creation" do
    sign_in @student
    assert_no_difference('Blurb.count') do
      post blurbs_url(lang: @blurb.language.code), params: { blurb: { title: "", content: "" } }
    end
    assert_response :unprocessable_entity
  end

  test "should handle non-existent blurb access" do
    get blurb_url(id: -1, lang: @blurb.language.code)
    assert_redirected_to root_url
  end
end
