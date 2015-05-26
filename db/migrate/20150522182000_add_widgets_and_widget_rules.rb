class AddWidgetsAndWidgetRules < ActiveRecord::Migration
  def self.up
    create_table :widget_rules , force: true do |t|
      t.references :controlled, polymorphic: true, index: true
      t.timestamps null: false    
    end
    create_table :widgets, force: true do |t|
      t.string :name    
      t.references :template, index: true
      t.belongs_to :user
      t.boolean :is_admited, default: false
      t.boolean :is_moderable, default: false
      t.boolean :is_template, default: false
      t.boolean :is_readonly, default: true
      t.timestamps null: false    
    end
    create_table :widget_rule_widgets, force: true, id: false do |t|
      t.belongs_to :widget, index: true
      t.belongs_to :widget_rule, index: true
    end
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end

end
