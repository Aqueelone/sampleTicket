class TicketStatus < ActiveRecord::Base
  has_many :tickets
  has_many :widget_rules, as: :controlled
  has_many :users, :through => :tickets
  has_many :widgets, :through => :widget_rules
  
  attr_accessible :name, :position, :is_moderable, :is_closed
  validates :name, :position, presence: true
  
  def is_associated?
    tickets.count > 0
  end
end
