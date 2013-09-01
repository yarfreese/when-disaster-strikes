require 'spec_helper'

feature "Editing posts" do
  let!(:project) { FactoryGirl.create(:project) }
  let!(:user) { FactoryGirl.create(:user) }
  let!(:post) do
    post = FactoryGirl.create(:post, project: project)
    post.update(user: user)
    post
  end

  before do
    define_permission!(user, "view", project)
    sign_in_as!(user)
    visit '/'
    click_link project.name
    click_link post.title
    click_link "Edit Post"
  end

  scenario "Updating a post" do
    fill_in "Title", with: "Bo again"
    click_button "Update Post"

    expect(page).to have_content "Post has been updated"

    within("#post h2") do
      expect(page).to have_content("Bo again")
    end

    expect(page).to_not have_content post.title
  end

  scenario "Updating a post with invalid information" do
    fill_in "Title", with: ""
    click_button "Update Post"

    expect(page).to have_content("Post has not been updated.")
  end
end
