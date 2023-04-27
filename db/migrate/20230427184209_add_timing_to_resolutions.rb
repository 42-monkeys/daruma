class AddTimingToResolutions < ActiveRecord::Migration[7.0]
  def change
    add_column :resolutions, :target_time, :date  
    add_column :resolutions, :commitment, :integer  
  end
end
