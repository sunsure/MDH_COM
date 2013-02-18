require 'spec_helper'

describe UsersController do
  before(:each) do
    @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
    # Note: we use the test_user because users
    # aren't allowed to destroy their own accounts
    @test_user = FactoryGirl.create(:user)
  end

  describe "GET :new" do
    it "should setup @user as a new User instance" do
      get :new
      assigns(:user).should be_a_new(User)
    end

    it "should return HTTP success" do
      get :new
      response.should be_success
    end

    it "should render the new template" do
      get :new
      response.should render_template(:new)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      before(:each) do
        @attr =
          {
            first_name: "Mark",
            last_name: "Holmberg",
            email: "user@example.com",
            password: "foobar",
            password_confirmation: "foobar"
          }
      end

      it "creates a new User" do
        expect {
          post :create, {user: @attr}
        }.to change(User, :count).by(1)
      end

      it "assigns a newly created user as @user" do
        post :create, {user: @attr}
        assigns(:user).should be_a(User)
        assigns(:user).should be_persisted
      end

      it "redirects to the created user" do
        post :create, {user: @attr}
        response.should redirect_to(login_url)
      end
    end

    describe "with invalid params" do
      before(:each) do
        @attr =
          {
            first_name: "",
            password: "",
            password_confirmation: "",
          }
      end

      it "assigns a newly created but unsaved user as @user" do
        post :create, user: @attr
        assigns(:user).should be_a_new(User)
      end

      it "re-renders the 'new' template" do
        post :create, user: @attr
        response.should render_template("new")
      end
    end
  end

  describe "GET :edit" do
    before(:each) do
      @commenter = FactoryGirl.create(:user_with_roles, with_roles: ["commenter"])
      login_as(@commenter)
    end
    it "should get the right user" do
      get :edit, { id: @commenter.id }
      assigns(:user).should eq(@commenter)
    end

    it "should return HTTP success" do
      get :edit, { id: @commenter.id }
      response.should be_success
    end

    it "should render the edit template" do
      get :edit, { id: @commenter.id }
      response.should render_template("edit")
    end
  end

  describe "PUT update" do
    before(:each) do
      @commenter = FactoryGirl.create(:user_with_roles, with_roles: ["commenter"])
      login_as(@commenter)
    end
    describe "with valid params" do
      before(:each) do
        @attr =
          {
            first_name: "Mark",
            last_name: "Holmberg",
            email: "user@example.com",
            password: "foobar",
            password_confirmation: "foobar"
          }
      end

      it "updates the requested user" do
        put :update, {id: @commenter, user: {first_name: "mark"}}
      end

      it "assigns the requested user as @commenter" do
        put :update, {id: @commenter.id, user: @attr}
        assigns(:user).should eq(@commenter)
      end

      it "redirects to the user" do
        put :update, {id: @commenter, user: @attr}
        response.should redirect_to(dashboard_my_url)
      end
    end

    describe "with invalid params" do
      before(:each) do
        @attr =
          {
            first_name: "",
            email: "invalid_email",
            password: "foobar",
            password_confirmation: "",
          }
      end

      it "assigns the user as @commenter" do
        put :update, id: @commenter, user: @attr
        assigns(:user).should eq(@commenter)
      end

      it "re-renders the 'edit' template" do
        put :update, id: @commenter, user: @attr
        response.should render_template("edit")
      end
    end
  end


  describe "DELETE destroy" do
    before(:each) do
      login_as(@user)
    end
    it "destroys the requested user" do
      expect {
        delete :destroy, {id: @test_user}
      }.to change(User, :count).by(-1)
    end

    it "redirects to the user list" do
      delete :destroy, {id: @test_user}
      response.should redirect_to(users_url)
    end

    it "prevents them from destroying their own account" do
      lambda do
        delete :destroy, {id: @user}
        response.should redirect_to(users_url)
        flash[:error].should_not be_nil
        flash[:error].should eq("You cannot destroy your own account!")
      end.should_not change(User, :count).by(-1)
    end
  end

end
