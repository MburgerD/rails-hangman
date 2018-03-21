require 'rails_helper'

RSpec.describe "games/show", type: :view do
  before(:each) do
    @game = assign(:game, Game.create!(
                            :word => "Word",
                            :guesses => "abc",
                            :lives => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Word/)
    expect(rendered).to match(/abc/)
    expect(rendered).to match(/2/)
  end

  it "renders show game form" do
    render

    assert_select "form[action=?][method=?]", "/games/#{@game.id}", "post" do
      assert_select "input[name=?]", "game[guess]"
    end
  end
end
