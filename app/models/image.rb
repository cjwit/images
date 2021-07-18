class Image < ApplicationRecord
    has_one_attached :imageFile, :dependent => :destroy
end
