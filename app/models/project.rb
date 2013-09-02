class Project < ActiveRecord::Base

  validates :name, presence: true

  has_many :posts, dependent: :delete_all

  has_many :permissions, as: :thing

  scope :viewable_by, ->(user) do
    joins(:permissions).where(permissions: { action: "view", user_id: user.id })
  end

  #scope :self.for, ->(user) do
  def self.for(user)
    user.admin? ? Project.all : Project.viewable_by(user)
  end

end
