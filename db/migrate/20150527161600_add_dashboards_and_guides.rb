class AddDashboardsAndGuides < ActiveRecord::Migration
  def self.up
    create_table :dashboards , force: true do |t|
      t.belongs_to :user
      t.belongs_to :ticket, array: true
      t.boolean :guide_on, default: true
      t.integer :guide_step, default: 1
      t.timestamps null: false          
    end    
    create_table :guides, force: true do |t|
      t.string :title
      t.integer :step
      t.string  :level
      t.belongs_to :next
      t.text  :text      
      t.timestamps null: false          
    end
    create_table :dashboard_widgets, force: true, id: false do |t|
      t.belongs_to :dashboard, index: true
      t.belongs_to :widget, index: true
    end
    create_table :events, force: true do |t|
      t.json :payload
      t.timestamps null: false   
    end
  end
  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
