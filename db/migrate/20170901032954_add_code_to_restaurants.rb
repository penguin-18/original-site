class AddCodeToRestaurants < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :code, :string
  end
end
