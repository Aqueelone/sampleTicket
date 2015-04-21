class Category < ActiveRecord::Base
  has_many :tickets
  attr_accessible :name
  validates :name, presence: true
  
  def is_associated?
    tickets.count > 0
  end
end
