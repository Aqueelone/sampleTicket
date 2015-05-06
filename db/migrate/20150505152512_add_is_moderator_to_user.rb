class AddIsModeratorToUser < ActiveRecord::Migration
  def self.up
    change_table(:users) do |t|
      t.boolean  "is_moderator",                           default: false
    end
    change_table(:ticket_statuses) do |t|      
      t.boolean  "is_moderable",                           default: false
    end
    change_table(:ticket_statuses) do |t|      
      t.boolean  "is_closed",                           default: false
    end
  end
  def self.down
    raise ActiveRecord::IrreversibleMigration
  end  
end
