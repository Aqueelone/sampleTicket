class TicketStatus < ActiveRecord::Base
  has_many :tickets
  
  attr_accessible :name, :position
  validates :name, :position, presence: true
  
  def is_associated?
    tickets.count > 0
  end
end
