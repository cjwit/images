require "test_helper"
include ActionDispatch::TestProcess::FixtureFile

class ImageFlowTest < ActionDispatch::IntegrationTest
  test "should be able to get homepage" do
    get "/"
    assert_response :success

    # only one .gallery-item box, which is the upload link
    assert_select "div.upload-link", 1
    assert_select "div.gallery-item", 1
  end

  test "should be able to upload a valid image" do
    get "/images/new"
    assert_response :success
    assert_select "form"

    # upload a valid file
    testFile = fixture_file_upload("jpg-test.jpg", "image/jpeg")
    post "/images", params: { image: { title: "A good title", imageFile: testFile }}

    # redirect to index
    assert_response :redirect
    follow_redirect!
    assert_response :success

    # index now has a new gallery item
    assert_select "div.upload-link", 1
    assert_select "div.gallery-item", 2
  end

  test "should not upload an invalid image file" do
    get "/images/new"
    assert_response :success
    assert_select "form"

    # upload a valid file
    testFile = fixture_file_upload("svg-test.svg", "image/svg")
    post "/images", params: { image: { title: "A good title", imageFile: testFile }}
    
    # rerender upload screen, but with a <ul> that includes one error message
    assert_response :success
    assert_select "form"
    assert_select "ul", 1 
    assert_select "li", 1
  end
end
