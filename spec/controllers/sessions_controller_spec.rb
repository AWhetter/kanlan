require 'spec_helper'

describe SessionsController do
  def log_in_user(new_user_id)
    session[:user_id] = new_user_id
  end

  def user_logged_in
    session[:user_id]
  end

  describe "new endpoint" do
    context "when a user is already logged in" do
      let!(:user) { FactoryGirl.create(:user) }

      before do
        log_in_user(user.id)
        get :new
      end

      it "does not render" do
        expect(response).to_not render_template('users/login_form')
      end
    end
  end

  describe "create endpoint" do
    context "when a user is already logged in" do
      let!(:user) { FactoryGirl.create(:user) }
      let!(:user2) { FactoryGirl.create(:user, username: "user2", ip: "1.1.1.1") }

      before do
        log_in_user(user.id)
        @request.env['REMOTE_ADDR'] = user.ip
        post :create, username: user2.username
      end

      it "shows an error" do
        expect(flash[:error]).to_not be_nil
      end

      it "does not login the user" do
        expect(user_logged_in).to_not eq (user2.id)
      end
    end

    context "when the username is invalid" do
      let!(:user) { FactoryGirl.create(:user) }

      before do
        @request.env['REMOTE_ADDR'] = user.ip
        post :create, username: "NotAUsername"
      end

      it "shows an error" do
        expect(flash[:error]).to_not be_nil
      end

      it "does not login the user" do
        expect(user_logged_in).to be_nil
      end
    end

    context "when the user is being logged in from a different ip address" do
      let!(:user) { FactoryGirl.create(:user) }

      before do
        @request.env['REMOTE_ADDR'] = "8.8.8.8"
        expect(request.remote_ip).to_not eq(user.ip)
        post :create, username: user.username
      end

      it "shows an error" do
        expect(flash[:error]).to_not be_nil
      end

      it "does not login the user" do
        expect(user_logged_in).to be_nil
      end
    end

    context "when the attributes are valid" do
      let!(:user) { FactoryGirl.create(:user) }

      before do
        @request.env['REMOTE_ADDR'] = user.ip
        post :create, username: user.username
      end

      it "tells the user that they are logged in" do
        expect(flash[:notice]).to_not be_nil
      end

      it "logs in the user" do
        expect(user_logged_in).to_not be_nil
      end
    end
  end

  describe "destroy endpoint" do
    let!(:user) { FactoryGirl.create(:user) }

    context "when a user is not logged in" do
      before do
        expect(user_logged_in).to be_nil
        delete :destroy
      end

      it "redirects to the home page" do
        expect(response).to redirect_to(root_url)
      end
    end

    context "when a user is logged in" do
      before do
        log_in_user(user.id)
        delete :destroy
      end

      it "tells the user that they have logged out" do
        expect(flash[:notice]).to_not be_nil
      end

      it "logs out the user" do
        expect(user_logged_in).to be_nil
      end
    end
  end
end
