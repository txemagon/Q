class CreateAcronyms < ActiveRecord::Migration
  def change
    create_table :acronyms do |t|
      t.string :key, unique: true
      t.string :name, unique: true
      t.string :expand

      t.timestamps null: false
    end
  end
end
