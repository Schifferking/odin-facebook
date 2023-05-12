class CreateRelationships < ActiveRecord::Migration[7.0]
  def change
    create_table :relationships do |t|
      t.integer :requester_id
      t.integer :requested_id
      t.string :relationship_type

      t.timestamps
    end
  end
end
