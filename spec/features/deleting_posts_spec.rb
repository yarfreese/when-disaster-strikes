require 'spec_helper'

feature "Deleting posts" do
  let!(:project) { FactoryGirl.create(:project) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:post) { FactoryGirl.create(:post, project: project, user: user) }

  before do
    define_permission!(user, "view", project)
    define_permission!(user, "delete posts", project)
    sign_in_as!(user)
    visit '/'
    click_link project.name
    click_link post.title
  end

  scenario "Deleting a post" do
    click_link "Delete Post"

    expect(page).to have_content("Post has been deleted.")
    expect(page.current_url).to eq(project_url(project))
  end
end

