class RemoveUserIdToRestaurant < ActiveRecord::Migration
  def change
    remove_reference :restaurants, :user, index: true, foreign_key: true
  end
end
