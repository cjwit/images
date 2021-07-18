class Image < ApplicationRecord
    has_one_attached :imageFile, :dependent => :destroy
    validates :title, length: { minimum: 3, maximum: 50 }
    validates :imageFile, presence: true
end
