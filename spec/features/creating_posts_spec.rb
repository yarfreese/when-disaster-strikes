require 'spec_helper'

feature "Creating Posts" do
  before do
    FactoryGirl.create(:project, name: "Bad Hair Day")

    visit '/'
    click_link "Bad Hair Day"
    click_link "New Post"
  end

  scenario "Can create a Post" do
    fill_in 'Title', with: 'Bo averts disaster'
    fill_in 'Description', with: 'Bo runs to high ground'
    click_button 'Create Post'

    expect(page).to have_content('Post has been created.')

    # post = Post.where(title: "Bo averts disaster", project_id: @project_id).first
    # expect(page.current_url).to eql(project_post_url(post))
  end
 
  scenario "Creating a Post without valid attributes fails" do
    click_button "Create Post"

    expect(page).to have_content("Post has not been created.")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Description can't be blank")
  end

  scenario "Description must be longer than 10 characters" do
    fill_in "Title", with: "Whatever"
    fill_in "Description", with: "it sucks"
    click_button "Create Post"

    expect(page).to have_content("Post has not been created.")
    expect(page).to have_content("Description is too short")
  end

end

