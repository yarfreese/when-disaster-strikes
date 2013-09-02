require 'spec_helper'

describe PostsController do
  let(:user) { FactoryGirl.create(:user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:post) { FactoryGirl.create(:post, project: project, user: user) }

  context "standard users" do
    it "cannot access a ticket for a project" do
      sign_in(user)
      get :show, :id => post.id, :project_id => project.id

      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to eql("The project you were looking for could not be found.")
    end
  end
end
