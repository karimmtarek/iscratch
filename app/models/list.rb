class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy
  validates :name, presence: true
  validate :uniqueness_of_name

  PERMISSION_OPTIONS = ["private", "public", "viewable"]
  validates :permission, inclusion: {in: PERMISSION_OPTIONS}

  # set :permission to public by default when creating a new list
  def permission
    self[:permission] || "public"
  end

  def uniqueness_of_name
    user = User.find(self.user_id)
    if user.lists.where(name: self.name).exists?
      errors.add(:name, "is already taken, be creative!")
    end
  end

  def public?
  end

  def viewable?
  end

  def private?
  end
end
