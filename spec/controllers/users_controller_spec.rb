require 'spec_helper'

describe UsersController do
  describe "create endpoint" do
    let(:new_user) do
      seat = FactoryGirl.create(:seat)
      to_return = FactoryGirl.attributes_for(:user)
      to_return.merge({ :seat_id => seat.id })
    end

    context "with an invalid new user" do
      let!(:old_count) do
        seat = FactoryGirl.create(:seat)
        user_obj = User.new(new_user)
        user_obj.seat = seat
        expect(user_obj.save).to be true
        expect(user_obj).to_not be_new_record

        User.count
      end

      before do
        post :create, :user => new_user
      end

      it "does not create the user" do
        user_obj = User.new(new_user)
        expect(user_obj.save).to be false
        expect(User.count).to eq(old_count)
      end

      it "redirects to creating a new user" do
        expect(response).to redirect_to(new_user_path)
      end

      it "returns an error" do
        expect(flash[:error]).to_not be_nil
      end

      it "does not log the user in" do
        expect(session[:user_id]).to be_nil
      end

      it "gives a useful error message depending on the parameters given"
    end

    context "with a valid new user" do
      let!(:old_count) { User.count }
      before do
        post :create, :user => new_user
      end

      it "creates the user" do
        user_obj = User.new(new_user)
        expect(user_obj).to_not be_valid
        expect(User.count).to eq(old_count + 1)
      end

      it "redirects to the home page" do
        expect(response).to redirect_to(root_url)
      end

      it "returns a status message" do
        expect(flash[:notice]).to_not be_nil
      end

      it "should log the user in" do
        expect(session[:user_id]).to_not be_nil
      end
    end
  end

  describe "new endpoint" do
    it "returns success" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "edit endpoint" do
    it "returns success" do
      get :new
      expect(response).to be_successful
    end
  end
end
