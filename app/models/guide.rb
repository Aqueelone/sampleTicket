class Guide < ActiveRecord::Base
  belongs_to :next, :class_name => "Guide", :foreign_key => "next_id"
  has_one :previous, :class_name => "Guide"
  
  attr_accessible :title, :step, :level, :text
end
