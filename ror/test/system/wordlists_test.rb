require "application_system_test_case"

class WordlistsTest < ApplicationSystemTestCase
  setup do
    @wordlist = wordlists(:one)
  end

  test "visiting the index" do
    visit wordlists_url
    assert_selector "h1", text: "Wordlists"
  end

  test "should create wordlist" do
    visit wordlists_url
    click_on "New wordlist"

    fill_in "Language", with: @wordlist.language_id
    fill_in "Name", with: @wordlist.name
    fill_in "Slug", with: @wordlist.slug
    click_on "Create Wordlist"

    assert_text "Wordlist was successfully created"
    click_on "Back"
  end

  test "should update Wordlist" do
    visit wordlist_url(@wordlist)
    click_on "Edit this wordlist", match: :first

    fill_in "Language", with: @wordlist.language_id
    fill_in "Name", with: @wordlist.name
    fill_in "Slug", with: @wordlist.slug
    click_on "Update Wordlist"

    assert_text "Wordlist was successfully updated"
    click_on "Back"
  end

  test "should destroy Wordlist" do
    visit wordlist_url(@wordlist)
    click_on "Destroy this wordlist", match: :first

    assert_text "Wordlist was successfully destroyed"
  end
end
