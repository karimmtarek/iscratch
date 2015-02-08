class List < ActiveRecord::Base
  belongs_to :user
  has_many :items, dependent: :destroy
  after_initialize :default_permission
  validates :name, presence: true
  validates_uniqueness_of :name, :scope => :user_id

  PERMISSION_OPTIONS = ["private", "public", "viewable"]
  validates :permission, inclusion: {in: PERMISSION_OPTIONS}

  def default_permission
    self.permission ||= "public"
  end

  def self.view_all
    where('permission != ?', 'private')
  end

  def other_users_private?(user)
    self.permission == 'private' && user.id != self.user_id
  end

  def other_users_viewable?(user)
    self.permission == 'viewable' && user.id != self.user_id
  end

  def no_permission?(user)
    self.other_users_viewable?(user) || self.other_users_private?(user)
  end

end
