require 'spec_helper'

feature "Deleting posts" do
  let!(:project) { FactoryGirl.create(:project) }
  let!(:post) { FactoryGirl.create(:post, project: project) }

  before do
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

