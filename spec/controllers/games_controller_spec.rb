require 'rails_helper'

describe GamesController do
  let(:valid_attributes) { { "word" => "foo", "lives" => 5 } }
  let(:invalid_attributes) { { "word" => 123, "lives" => 500 } }
  let(:game) { Game.create! valid_attributes }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_success
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: {id: game.to_param}
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Game" do
        expect {
          post :create, params: {game: valid_attributes}
        }.to change(Game, :count).by(1)
      end

      it "redirects to the created game" do
        post :create, params: {game: valid_attributes}
        expect(response).to redirect_to(Game.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {game: invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { { "guess" => "a" } }

      it "updates the requested game" do
        put :update, params: {id: game.to_param, game: new_attributes}
        game.reload
        expect(game.guesses).to eq "a"
      end

      it "updates the requested game's lives" do
        allow_any_instance_of(Game).to receive(:update_lives?)
        expect_any_instance_of(Game).to receive(:update_lives?)
        put :update, params: {id: game.id, game: new_attributes}
      end

      it "redirects to the game" do
        put :update, params: {id: game.to_param, game: new_attributes}
        expect(response).to redirect_to(game)
      end
    end

    context "with invalid params" do
      let(:new_invalid_attributes) { { "guess" => 123 } }

      it "returns a success response (i.e. to display the 'show' template)" do
        put :update, params: {id: game.to_param, game: new_invalid_attributes}
        expect(response).to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested game" do
      game = Game.create! valid_attributes
      expect {
        delete :destroy, params: {id: game.to_param}
      }.to change(Game, :count).by(-1)
    end

    it "redirects to the games list" do
      delete :destroy, params: {id: game.to_param}
      expect(response).to redirect_to(games_url)
    end
  end
end
