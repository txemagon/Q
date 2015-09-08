class CreateRegisterModels < ActiveRecord::Migration
  def change
    create_table :register_models do |t|
      t.string :name
      t.text :explanation

      t.timestamps null: false
    end
  end
end
