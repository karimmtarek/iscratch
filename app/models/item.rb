class Item < ActiveRecord::Base
  belongs_to :list, dependent: :destroy

  validates :name, presence: true

  COMPLETED_OPTIONS = [true, false]
  validates :completed, inclusion: {in: COMPLETED_OPTIONS}

  # set :completed to false by default when creating a new item
  def completed
    self[:completed] || false
  end
end
