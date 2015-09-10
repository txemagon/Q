class AddDocumentToRegisterModel < ActiveRecord::Migration
  def up
  	add_attachment :register_models, :document
  end

  def down
  	remove_attachment :register_models, :document
  end

end
