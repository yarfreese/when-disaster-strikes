require 'spec_helper'

feature "hidden links" do
  before do
    quotation = FactoryGirl.create(:quotation)
  end
  let(:user) { FactoryGirl.create(:user) }
  let(:admin) { FactoryGirl.create(:admin_user) }
  let(:project) { FactoryGirl.create(:project) }
  let(:post) { FactoryGirl.create(:post, project: project, user: user) }

  context "anonymous users" do
    scenario "cannot see the New Project link" do
      visit '/'
      assert_no_link_for "New Project"
    end

    scenario "cannot see the Edit Project link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end

    scenario "cannot see the Delete Project link" do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end
  end

  context "regular users" do
    before { sign_in_as!(user) }

    scenario "cannot see the New Project link" do
      visit '/'
      assert_no_link_for "New Project"
    end

    scenario "cannot see the Edit Project link" do
      visit project_path(project)
      assert_no_link_for "Edit Project"
    end

    scenario "cannot see the Delete Project link" do
      visit project_path(project)
      assert_no_link_for "Delete Project"
    end

    scenario "New post link is shown to a user with permission" do
      define_permission!(user, "view", project)
      define_permission!(user, "create posts", project)
      visit project_path(project)
      assert_link_for "New Post"
    end

    scenario "New post link is hidden from a user without permission" do
      define_permission!(user, "view", project)
      visit project_path(project)
      assert_no_link_for "New Post"
    end

    scenario "Edit post link is shown to a user with permission" do
      post
      define_permission!(user, "view", project)
      define_permission!(user, "edit posts", project)
      visit project_path(project)
      click_link post.title
      assert_link_for "Edit Post"
    end

    scenario "Edit post link is hidden from a user without permission" do
      post
      define_permission!(user, "view", project)
      visit project_path(project)
      click_link post.title
      assert_no_link_for "Edit Post"
    end

    scenario "Delete post link is shown to a user with permission" do
      post
      define_permission!(user, "view", project)
      define_permission!(user, "delete posts", project)
      visit project_path(project)
      click_link post.title
      assert_link_for "Delete Post"
    end

    scenario "Delete post link is hidden from a user without permission" do
      post
      define_permission!(user, "view", project)
      visit project_path(project)
      click_link post.title
      assert_no_link_for "Delete Post"
    end

  end

  context "admin users" do
    before { sign_in_as!(admin) }

    scenario "can see the New Project link" do
      visit '/'
      assert_link_for "New Project"
    end

    scenario "can see the Edit Project link" do
      visit project_path(project)
      assert_link_for "Edit Project"
    end

    scenario "can see the Delete Project link" do
      visit project_path(project)
      assert_link_for "Delete Project"
    end

    scenario "New post link is shown to admins" do
      visit project_path(project)
      assert_link_for "New Post"
    end

    scenario "Edit post link is shown to admins" do
      post
      visit project_path(project)
      click_link post.title
      assert_link_for "Edit Post"
    end

    scenario "Delete post link is shown to admins" do
      post
      visit project_path(project)
      click_link post.title
      assert_link_for "Delete Post"
    end

  end

end

