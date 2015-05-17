class Comment < ActiveRecord::Base
  
    
  def is_parent?
    !Comment.where(parent_id: :id).empty?
  end
  
end