class Widget < ActiveRecord::Base
  has_and_belongs_to_many :widget_rules
  has_many :ticket_statuses, :through => :widget_rules
  has_many :categories, :through => :widget_rules
  has_many :from_templaters, class_name: "Widget", foreign_key: "template_id"
  
  belongs_to :template, class_name: "Widget"
  belongs_to :user
  
  attr_accessible :name, :is_admited, :is_moderable, :is_template
  validates :name, presence: true
end
