require 'rails_helper'

describe "hangman/show.html.erb" do
  it "displays the hangman heading" do
    render
    expect(rendered).to include("Let's play HANGMAN!")
  end
end
