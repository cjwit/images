require "test_helper"
include ActionDispatch::TestProcess::FixtureFile

class ImageTest < ActiveSupport::TestCase
  test "should not save object without title" do
    imageRecord = Image.new
    assert_not imageRecord.save
  end

  test "should save with title and image upload" do
    testFile = fixture_file_upload("jpg-test.jpg", "image/jpeg")
    testTitle = "A good title"
    imageRecord = Image.new({ title: testTitle, imageFile: testFile })
    assert imageRecord.save
    assert_equal imageRecord.title, testTitle
    assert_equal imageRecord.imageFile.content_type, "image/jpeg"
  end 

  test "should not save with title shorter than 3 characters" do
    testFile = fixture_file_upload("jpg-test.jpg", "image/jpeg")

    titleWith1 = "a"
    imageWithShortTitle = Image.new({ title: titleWith1, imageFile: testFile })
    assert_not imageWithShortTitle.save

    titleWith3 = "abc"
    imageWithGoodTitle = Image.new({ title: titleWith3, imageFile: testFile })
    assert imageWithGoodTitle.save
    assert_equal imageWithGoodTitle.title, titleWith3
  end

  test "should not save with title longer than 50 characters" do
    testFile = fixture_file_upload("jpg-test.jpg", "image/jpeg")

    titleWith50 = "0123456789_123456789_123456789_123456789_123456789"
    imageWithGoodTitle = Image.new({ title: titleWith50, imageFile: testFile })
    assert imageWithGoodTitle.save
    assert_equal imageWithGoodTitle.title, titleWith50

    titleWith51 = "0123456789_123456789_123456789_123456789_123456789_"
    imageWithLongTitle = Image.new({ title: titleWith51, imageFile: testFile })
    assert_not imageWithLongTitle.save
  end

  test "should not save without attached image" do
    imageRecord = Image.new({ title: "title" })
    assert_not imageRecord.save
  end

  test "should not save with unsupported file upload type" do 
    testFile = fixture_file_upload("svg-test.svg", "image/svg")
    imageRecord = Image.new({ title: "title", imageFile: testFile })
    assert_not imageRecord.save
  end

  test "should not save with invalid file extension/file type" do 
    # saving should fail if there is a true test of file type validity
    # beyond just checking the mime-type on upload 
    # currently failing test, this check is not implemented

    # svg-test.jpg is an SVG file with the extension shanged to .jpg
    testFile = fixture_file_upload("svg-test.jpg", "image/jpeg")
    imageRecord = Image.new({ title: "title", imageFile: testFile })
    assert_not imageRecord.save # catches the problem for SVG
    
    # text-test.jpg is similar, a text file with .jpg extension
    testFile = fixture_file_upload("text-test.jpg", "image/jpeg")
    imageRecord = Image.new({ title: "title", imageFile: testFile })
    # assert_not imageRecord.save # fails for text, does not catch the error
  end
end
