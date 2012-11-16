class AddCountryAndCityToPunch < ActiveRecord::Migration
  def change
    add_column :punches, :country, :string
    add_column :punches, :city, :string
  end
end
