class Photo
  include Mongoid::Document
  include Mongoid::Timestamps

  validates_presence_of :image

  belongs_to :user
  mount_uploader :image, PhotoUploader
end
