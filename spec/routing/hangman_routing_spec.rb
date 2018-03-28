require 'rails_helper'

describe "routing to hangman" do
  it "routes / to hangman#show" do
    expect(:get => "/").to route_to(
      :controller => "hangman",
      :action => "show"
    )
  end
end
