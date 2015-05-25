class AddWidgetsAndWidgetRules < ActiveRecord::Migration
  def self.up
    create_table :widget_rules , force: true do |t|
      t.references :controlled, polymorphic: true, index: true
      t.boolean :allow, default: true      
      t.timestamps null: false    
    end
    create_table :widgets, force: true do |t|
      t.string :name    
      t.references :template, index: true
      t.belongs_to :user
      t.boolean :is_admited, default: false
      t.boolean :is_moderable, default: false
      t.boolean :is_template, default: false
      t.timestamps null: false    
    end
    create_table :widgets_widget_rules, force: true, id: false do |t|
      t.belongs_to :widgets, index: true
      t.belongs_to :widget_rules, index: true
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end

end
