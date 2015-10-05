class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name, unique: true

      # awesome nested set
      # compulsory
      t.integer :parent_id, null: true, index: true
      t.integer :lft, null: false, index: true
      t.integer :rgt, null: false, index: true

      # optional
      t.integer :depth, null: false, default: 0
      t.integer :children_count, null: false, default: 0

      t.timestamps null: false
    end
  end
end
