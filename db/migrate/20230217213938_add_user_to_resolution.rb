class AddUserToResolution < ActiveRecord::Migration[7.0]
  def change
    change_table :resolutions do |t|
      t.references :user, null: false, foreign_key: true
    end
  end
end
