class TicketStatus < ActiveRecord::Base
  has_many :tickets
  
  attr_accessible :name, :position, :is_moderable, :is_closed
  validates :name, :position, presence: true
  
  def is_associated?
    tickets.count > 0
  end
end
