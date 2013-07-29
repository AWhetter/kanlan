require 'spec_helper'

describe GamesController do

  describe "new endpoint" do
    it "returns success" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "create endpoint" do
    context "given an invalid game" do
      it "does not create a game"
    end

    context "given a valid game" do
      it "creates a game"
    end
  end

end
