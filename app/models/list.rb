class List < ActiveRecord::Base
  has_many :items
  validates :name, presence: true

  PERMISSION_OPTIONS = ["private", "public", "viewable"]
  validates :permission, inclusion: {in: PERMISSION_OPTIONS}

  # set :permission to public by default when creating a new list
  def permission
    self[:permission] || "public"
  end
end
