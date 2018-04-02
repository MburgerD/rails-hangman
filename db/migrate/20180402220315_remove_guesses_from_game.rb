class RemoveGuessesFromGame < ActiveRecord::Migration[5.1]
  def change
    remove_column :games, :guesses, :string, default: ""
  end
end
