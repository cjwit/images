# Image upload

This is a small demo application built using Ruby on Rails (ruby version 3.0.0 and rails version 6.1.4). It has two pages: a `root`, also routed through `/images`, showing all uploaded images and another at `/images/new` for uploading a new image.

Images are stored using Active Storage. Locally, they are configured using PostgreSQL and local storage (see `config/database.yml` to define environments).

## To do

* Set up file type validation
* Set up testing and CI
* Do some basic styling to the pages
* Configure Active Storage for production
* Check setup with a fresh version and describe the process (clone, install dependencies, create databases, run webpack if necessary, and start with the server)
* Document features
* Document testing, Active Storage creation, deployment
