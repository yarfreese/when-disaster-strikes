class Project < ActiveRecord::Base
  validates :name, presence: true
  has_many :posts, dependent: :delete_all
end
