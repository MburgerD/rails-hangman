require 'rails_helper'

describe GuessesController do
  describe "POST #create" do
    let(:game) { Game.create word: 'foo', lives: 5 }
    let(:valid_params) { { :guess => { "letter" => "a" }, :game_id => game.id } }
    let(:invalid_params) { { :guess => { "letter" => "123" }, :game_id => game.id } }

    context "with valid params" do
      it "creates a new Guess" do
        expect {
          post :create, params: valid_params
        }.to change(Guess, :count).by(1)
      end

      it "redirects to the associated game" do
        post :create, params: valid_params
        expect(response).to redirect_to(game)
      end
    end

    context "with invalid params" do
      it "does not create a new Guess" do
        expect {
          post :create, params: invalid_params
        }.to change(Guess, :count).by(0)
      end

      it "redirects to the associated game" do
        post :create, params: invalid_params
        expect(response).to render_template('games/show')
      end
    end
  end
end
