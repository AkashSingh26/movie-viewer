class CreateMovies < ActiveRecord::Migration[6.1]
  def change
    create_table :movies do |t|
      t.string :title, null: false
      t.string :decription
      t.integer :release_year
      t.timestamps
    end
  end
end
