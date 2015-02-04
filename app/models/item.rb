class Item < ActiveRecord::Base
  belongs_to :list
  after_initialize :default_completed

  validates :name, presence: true

  COMPLETED_OPTIONS = [true, false]
  validates :completed, inclusion: {in: COMPLETED_OPTIONS}


  # set :completed to false by default when creating a new item
  def default_completed
    self.completed ||= false if self.completed.nil?
  end

  private

  # def set_completed
  #   self.completed = false if self.completed.blank?
  # end
end
