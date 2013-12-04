class Post < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_many :assets
  accepts_nested_attributes_for :assets
  validates :title, presence: true
  validates :description, presence: true,
            length: { minimum: 10 }
  # moved to asset.rb 
  # mount_uploader :asset, AssetUploader
end
