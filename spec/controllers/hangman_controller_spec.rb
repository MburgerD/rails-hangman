require 'rails_helper'

describe HangmanController do
  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      get :show
      expect(response).to render_template("show")
    end
  end
end
