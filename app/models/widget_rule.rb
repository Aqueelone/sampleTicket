class WidgetRule < ActiveRecord::Base
  belongs_to :controlled, polymorphic: true 
  has_and_belongs_to_many :widgets
end
