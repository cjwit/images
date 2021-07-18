class Image < ApplicationRecord
    has_one_attached :imageFile, :dependent => :destroy
    validates :title, length: { minimum: 3, maximum: 50 }
    validates :imageFile, presence: true
    validate :correct_document_mime_type
    ACCEPTED_FORMATS = ["image/jpg", "image/png", "image/gif"]
    
    private
    def correct_document_mime_type
        if imageFile.attached? && !imageFile.content_type.in?(ACCEPTED_FORMATS)
            errors.add(:imageFile, "Only JPEG, PNG, and GIF files are accepted.")
        end
    end
end
