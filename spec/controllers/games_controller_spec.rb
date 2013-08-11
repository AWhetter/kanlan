require 'spec_helper'

describe GamesController do

  describe "new endpoint" do
    it "returns success" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "create endpoint" do
    let(:new_game) { FactoryGirl.attributes_for(:game) }
    context "given an invalid game" do
      let!(:old_count) do
        game_obj = Game.new(new_game)
        expect(game_obj.save).to be true
        expect(game_obj).to_not be_new_record

        Game.count
      end

      before do
        post :create, :game => new_game
      end

      it "does not create the game" do
        game_obj = Game.new(new_game)
        expect(game_obj.save).to be false
        expect(Game.count).to eq(old_count)
      end

      it "redirects to creating a new game" do
        expect(response).to redirect_to(new_game_path)
      end

      it "returns an error" do
        expect(flash[:error]).to_not be nil
      end

      it "gives a useful error message depending on the given parameters"
    end

    context "given a valid game" do
      let!(:old_count) { Game.count }
      before do
        post :create, :game => new_game
      end

      it "creates the game" do
        game_obj = Game.new(new_game)
        expect(game_obj.save).to be false
        expect(Game.count).to eq(old_count + 1)
      end

      it "redirects to creating a new post" do
        expect(response).to redirect_to(new_post_path)
      end

      it "returns a status message" do
        expect(flash[:notice]).to_not be nil
      end
    end
  end
end
