class AddForeignKeysToRelationships < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :relationships, :users, column: :requester_id
    add_foreign_key :relationships, :users, column: :requested_id
  end
end
