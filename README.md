[![Build Status](https://travis-ci.com/cjwit/images.svg?branch=main)](https://travis-ci.com/cjwit/images)

# Image upload

The working application is available at <https://witulski-vtaku.herokuapp.com>.

This is a small demo application built using Ruby on Rails (Ruby version 3.0.0 and Rails version 6.1.4). It has two pages: a `root`, also routed through `/images`, showing all uploaded images and another at `/images/new` for uploading a new image.

Images are stored using Active Storage. Locally, they are configured using PostgreSQL and local storage (see `config/database.yml` to define environments).

## Notes

* The gallery photos are 800x800 thumbnails that link to the full size images.
* Validation on file types happens in the upload form (allows PNG, JPEG, and GIF MIME types) and in the `image` model. This does not account for files whose file extensions have been changed and presents a security risk. I believe that opening a file in ImageMagick might be able to help present a `valid?` method to do this check, but it's not implemented.
* The title/caption validation requires a 3-50 character short description for the gallery.
* This demo application includes basic unit testing for the `Image` model and integration testing using some fixtures to check validation. It includes one test that should fail—but is commented out—because the particular validation check is not implemented.
* A simple continuous integration process is set up for testing on each build in this application through Travis-CI. The status is shared in the image at the top of this file.

## To do

* Configure Active Storage for production (started the process of setting up S3, but ran into errors that I haven't been able to identify yet)
* Check setup with a fresh version and describe the process (clone, install dependencies, create databases, run webpack if necessary, and start with the server)
* Document features
