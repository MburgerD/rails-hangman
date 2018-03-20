require 'rails_helper'

RSpec.describe "hangman/index.html.erb", type: :view do
  it "displays the hangman heading" do
    render
    expect(rendered).to include("Let's play HANGMAN!")
  end
end
