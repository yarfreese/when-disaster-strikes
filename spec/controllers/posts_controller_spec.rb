require 'spec_helper'

describe PostsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:blog_post) { FactoryGirl.create(:post, project: project, user: user) }

  context "standard users" do
    it "cannot access a post for a project" do
      sign_in(user)
      get :show, :id => blog_post.id, :project_id => project.id

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eql("The project you were looking for could not be found.")
    end
  end

  context "with permission to view the project" do
    before do
      sign_in(user)
      define_permission!(user, "view", project)
    end

    def cannot_create_posts!
      response.should redirect_to(project)
      message = "You cannot create posts on this project."
      flash[:alert].should eql(message)
    end

    it "cannot begin to create a post" do
      get :new, :project_id => project.id
      cannot_create_posts!
    end

    it "cannot create a post without permission" do
      post :create, :project_id => project.id
      cannot_create_posts!
    end
  end
end
