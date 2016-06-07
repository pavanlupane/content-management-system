class AlterSection < ActiveRecord::Migration
  
  def up
  	add_column("sections","section_id",:integer, :after => "name")
  	add_index("sections","section_id")
  end

  def down
  	remove_index("sections","section_id")
  	remove_column("sections","section_id")
  end
  
end
