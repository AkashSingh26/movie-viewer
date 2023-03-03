class CreateRecommendations < ActiveRecord::Migration[6.1]
  def change
    create_table :recommendations do |t|
      t.references :movie, foreign_key: true      
      t.timestamps
    end
  end
end
