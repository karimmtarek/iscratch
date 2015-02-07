class Item < ActiveRecord::Base
  belongs_to :list
  after_initialize :default_completed

  validates :name, presence: true

  # COMPLETED_OPTIONS = [true, false]
  # validates :completed, inclusion: {in: COMPLETED_OPTIONS}
  validate :true_or_false?


  # set :completed to false by default when creating a new item
  def default_completed
    self.completed ||= false if self.completed.nil?
  end

  def true_or_false?
    unless self.completed == true || self.completed == false
      errors.add(:completed, "must be a boolean value!")
    end
  end

  private

  # def set_completed
  #   self.completed = false if self.completed.blank?
  # end
end
