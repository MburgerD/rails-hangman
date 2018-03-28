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
      get :show, params: { id: game.id }
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
    context "with valid custom params" do
      it "creates a new Game" do
        expect {
          post :create, params: { game: valid_attributes }
        }.to change(Game, :count).by(1)
      end

      it "redirects to the created game" do
        post :create, params: { game: valid_attributes }
        expect(response).to redirect_to(Game.last)
      end

      it "flashes success message" do
        post :create, params: { game: valid_attributes }
        expect(flash[:success]).to be_present
      end
    end

    context "with valid random game params" do
      let(:random_game_params) { {  generate_word: "Create game with a random word" } }

      it "creates a new Game" do
        expect {
          post :create, params: random_game_params
        }.to change(Game, :count).by(1)
      end

      it "redirects to the created game" do
        post :create, params: random_game_params
        expect(response).to redirect_to(Game.last)
      end

      it "flashes success message" do
        post :create, params: random_game_params
        expect(flash[:success]).to be_present
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { game: invalid_attributes }
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with invalid guess" do
      let(:invalid_guess) { { "guess" => 123 } }

      it "returns a success response (i.e. to display the 'show' template)" do
        put :update, params: { id: game.id, game: invalid_guess }
        expect(response).to be_success
      end
    end

    context "correct guess" do
      let(:correct_guess) { { "guess" => "f" } }

      it "adds guess to guesses" do
        put :update, params: { id: game.id, game: correct_guess }
        game.reload
        expect(game.guesses).to eq "f"
      end

      it "does not deduct a life" do
        allow_any_instance_of(Game).to receive(:update_lives?)
        expect_any_instance_of(Game).to receive(:update_lives?)
        put :update, params: { id: game.id, game: correct_guess }
        expect(game.lives).to eq 5
      end

      it "redirects to the game" do
        put :update, params: { id: game.id, game: correct_guess }
        expect(response).to redirect_to(game)
      end

      it "flashes success message" do
        put :update, params: { id: game.id, game: correct_guess }
        expect(flash[:success]).to be_present
      end
    end

    context "incorrect guess" do
      let(:incorrect_guess) { { "guess" => "z" } }

      it "adds guess to guesses" do
        put :update, params: { id: game.id, game: incorrect_guess }
        game.reload
        expect(game.guesses).to eq "z"
      end

      it "deducts a life" do
        put :update, params: { id: game.id, game: incorrect_guess }
        game.reload
        expect(game.lives).to eq 4
      end

      it "redirects to the game" do
        put :update, params: { id: game.id, game: incorrect_guess }
        expect(response).to redirect_to(game)
      end

      it "flashes danger message" do
        put :update, params: { id: game.id, game: incorrect_guess }
        expect(flash[:danger]).to be_present
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested game" do
      game = Game.create! valid_attributes
      expect {
        delete :destroy, params: { id: game.id }
      }.to change(Game, :count).by(-1)
    end

    it "redirects to the games list" do
      delete :destroy, params: { id: game.id }
      expect(response).to redirect_to(games_url)
    end
  end
end
