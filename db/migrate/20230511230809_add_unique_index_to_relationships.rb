class AddUniqueIndexToRelationships < ActiveRecord::Migration[7.0]
  def change
    add_index :relationships, [:requester_id, :requested_id], unique: true
  end
end
