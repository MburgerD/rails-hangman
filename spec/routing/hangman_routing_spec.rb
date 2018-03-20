require 'rails_helper'

RSpec.describe "routing to hangman", :type => :routing do
  it "routes / to hangman#index" do
    expect(:get => "/").to route_to(
      :controller => "hangman",
      :action => "index"
    )
  end
end
