require 'rails_helper'

RSpec.describe "games/new", type: :view do
  before(:each) do
    assign(:game, Game.new(
                    :word => "MyString",
                    :lives => 1
    ))
  end

  it "renders new game form" do
    render

    assert_select "form[action=?][method=?]", games_path, "post" do
      assert_select "input[name=?]", "game[word]"

      assert_select "input[name=?]", "game[guesses]", false

      assert_select "input[name=?]", "game[lives]"
    end
  end
end
