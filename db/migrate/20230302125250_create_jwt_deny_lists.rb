class CreateJwtDenyLists < ActiveRecord::Migration[6.1]
  def change
    create_table :jwt_denylist do |t|
      t.string :jti, null: false
      t.datetime :exp, null: false
      t.references :user, foreign_key: true     
      t.timestamps
    end
    add_index :jwt_denylist, :jti
  end
end
