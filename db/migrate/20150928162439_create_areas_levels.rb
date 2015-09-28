class CreateAreasLevels < ActiveRecord::Migration
  def change
    create_table :areas_levels, id: false do |t|
    	t.belongs_to :level, index: true
    	t.belongs_to :area,  index: true
    end
  end
end
