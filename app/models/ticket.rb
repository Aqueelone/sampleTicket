class Ticket < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :ticket_status
  belongs_to :admin_mailer
  attr_accessible :title, :description, :user_id, :category_id, :ticket_status_id
  validates :title, :description, :user_id, :category_id, :ticket_status_id, presence: true
    
end
