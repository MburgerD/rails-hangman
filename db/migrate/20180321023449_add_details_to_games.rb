class AddDetailsToGames < ActiveRecord::Migration[5.1]
  def change
    change_column :games, :guesses, :string, :default => ''
  end
end
