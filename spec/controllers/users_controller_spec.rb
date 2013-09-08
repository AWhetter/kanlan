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

  describe "update endpoint" do
    let!(:user) do
      seat = FactoryGirl.create(:seat)
      to_return = FactoryGirl.attributes_for(:user)
      to_return.merge({ :seat_id => seat.id })
    end

    let!(:user_id) do
      user_obj = FactoryGirl.create(:user, user)
      user_obj.id
    end

    context "given a non-existant user" do
      before do
        patch :update, :user => user, :id => -1
      end

      it "returns an error message" do
        expect(flash[:error]).to_not be_nil
      end

      it "redirects to creating a user" do
        expect(response).to redirect_to(new_user_path)
      end

      it "logs out the user" do
        expect(session[:user_id]).to be_nil
      end
    end

    context "given an invalid user" do
      before do
        updated = user.merge({ :seat_id => nil } )
        patch :update, :user => updated, :id => user_id
      end

      it "does not change the user" do
        user_obj = User.find(user_id)
        expect(user_obj[:ip]).to eq(user[:ip])
        expect(user_obj[:seat_id]).to eq(user[:seat_id])
        expect(user_obj[:username]).to eq(user[:username])
      end

      it "returns an error message" do
        expect(flash[:error]).to_not be_nil
      end

      it "redirects to editing the user" do
        expect(response).to redirect_to edit_user_path
      end
    end

    context "given a valid user" do
      before do
        # Don't update the IP address, only the username
        @request.env['REMOTE_ADDR'] = user[:ip]
        updated = user.merge({ :username => "NewUsername" } )
        patch :update, :user => updated, :id => user_id
      end

      it "changes the user" do
        user_obj = User.find(user_id)
        expect(user_obj[:ip]).to eq(user[:ip])
        expect(user_obj[:seat_id]).to eq(user[:seat_id])

        expect(user_obj[:username]).to_not eq(user[:username])
        expect(user_obj[:username]).to eq("NewUsername")
      end

      it "returns a confirmation message" do
        expect(flash[:notice]).to_not be_nil
      end

      it "redirects to the homepage" do
        expect(response).to redirect_to root_url
      end
    end

    it "does not use the session's user id" do
      session[:user_id] = user_id
      patch :update, :user => user, :id => -1
      expect(response).to_not be_successful
    end
  end
end
