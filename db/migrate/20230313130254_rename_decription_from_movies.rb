class RenameDecriptionFromMovies < ActiveRecord::Migration[6.1]
  def change
    rename_column :movies, :decription, :description
  end
end
