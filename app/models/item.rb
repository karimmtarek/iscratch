class Item < ActiveRecord::Base
  belongs_to :list
  after_initialize :default_completed

  validates :name, presence: true

  validate :true_or_false?

  def default_completed
    self.completed ||= false if self.completed.nil?
  end

  def true_or_false?
    unless self.completed == true || self.completed == false
      errors.add(:completed, "must be a boolean value!")
    end
  end

end
