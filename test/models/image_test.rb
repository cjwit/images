require "test_helper"
include ActionDispatch::TestProcess::FixtureFile

class ImageTest < ActiveSupport::TestCase
  test "should not save object without title" do
    imageRecord = Image.new
    assert_not imageRecord.save
  end

  test "should save with title and image upload" do
    testFile = fixture_file_upload('jpg-test.jpg', 'image/jpeg')
    imageRecord = Image.new({ title: "Plenty of letters", imageFile: testFile })
    assert imageRecord.save
  end 

  test "should not save with title shorter than 3 characters" do
    testFile = fixture_file_upload('jpg-test.jpg', 'image/jpeg')

    titleWith1 = "a"
    imageWithShortTitle = Image.new({ title: titleWith1, imageFile: testFile })
    assert_not imageWithShortTitle.save

    titleWith3 = "abc"
    imageWithGoodTitle = Image.new({ title: titleWith3, imageFile: testFile })
    assert imageWithGoodTitle.save
  end

  test "should not save with title longer than 50 characters" do
    testFile = fixture_file_upload('jpg-test.jpg', 'image/jpeg')

    titleWith50 = "0123456789_123456789_123456789_123456789_123456789"
    imageWithGoodTitle = Image.new({ title: titleWith50, imageFile: testFile })
    assert imageWithGoodTitle.save

    titleWith51 = "0123456789_123456789_123456789_123456789_123456789_"
    imageWithLongTitle = Image.new({ title: titleWith51, imageFile: testFile })
    assert_not imageWithLongTitle.save
  end
end
