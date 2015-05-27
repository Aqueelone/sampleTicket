class Dashboard < ActiveRecord::Base
belongs_to :user
has_and_belongs_to_many :widgets
has_many :sticked_tickets, :class_name => "Ticket"

attr_accessible :user_id, :widgets, :sticked_tickets, :guide_on, :guide_step   
end
