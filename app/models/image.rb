class Image < ApplicationRecord
    has_one_attached :imageFile, :dependent => :destroy
    validates :title, length: { minimum: 3, maximum: 50 }
    validates :imageFile, presence: true
    validate :correct_document_mime_type
    
    
    private
    def correct_document_mime_type
        if imageFile.attached? && !imageFile.content_type.in?(%w("image/jpeg"))
            errors.add(:imageFile, "Only JPEG files are accepted.")
        end
    end
end
