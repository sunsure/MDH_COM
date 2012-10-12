require 'spec_helper'

describe UsersController do
  before(:each) do
    @user = FactoryGirl.create(:user_with_roles, with_roles: ["admin"])
    # Note: we use the test_user because users
    # aren't allowed to destroy their own accounts
    @test_user = FactoryGirl.create(:user)
    login_as(@user)
  end

  describe "GET index" do
    it "returns HTTP success" do
      get :index
      response.should be_success
    end

    it "renders the index template" do
      get :index
      response.should render_template(:index)
    end

    it "assigns all users in the variable" do
      get :index
      assigns(:users).should eq(User.all)
    end
  end

  describe "GET show" do
    it "finds the right user" do
      get :show, {id: @user.id}
      assigns(:user).should eq(@user)
    end

    it "should render the show template" do
      get :show, {id: @user.id}
      response.should render_template(:show)
    end

    it "should return HTTP success" do
      get :show, {id: @user.id}
      response.should be_success
    end
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

  describe "GET :edit" do
    it "should get the right user" do
      get :edit, { id: @user.id }
      assigns(:user).should eq(@user)
    end

    it "should return HTTP success" do
      get :edit, { id: @user.id }
      response.should be_success
    end

    it "should render the new template" do
      get :edit, { id: @user.id }
      response.should render_template(:edit)
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
        response.should redirect_to(User.last)
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

  describe "PUT update" do
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
        put :update, {id: @user, user: {first_name: "mark"}}
      end

      it "assigns the requested user as @user" do
        put :update, {id: @user.id, user: @attr}
        assigns(:user).should eq(@user)
      end

      it "redirects to the user" do
        put :update, {id: @user, user: @attr}
        response.should redirect_to(@user)
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

      it "assigns the user as @user" do
        put :update, id: @user, user: @attr
        assigns(:user).should eq(@user)
      end

      it "re-renders the 'edit' template" do
        put :update, id: @user, user: @attr
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
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
