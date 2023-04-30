class AddOfferToResolutions < ActiveRecord::Migration[7.0]
  def change
    add_column :resolutions, :offer, :integer
  end
end
