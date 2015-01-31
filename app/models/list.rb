class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  PERMISSION_OPTIONS = ["private", "public", "viewable"]
  validates :permission, inclusion: {in: PERMISSION_OPTIONS}

  # set :permission to public by default when creating a new list
  def permission
    self[:permission] || "public"
  end

  def public?
  end

  def viewable?
  end

  def private?
  end
end
