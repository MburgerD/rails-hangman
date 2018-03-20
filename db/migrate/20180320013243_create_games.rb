class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.string :word
      t.array :guesses
      t.integer :lives

      t.timestamps
    end
  end
end
