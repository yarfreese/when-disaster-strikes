require 'spec_helper'

feature "Creating Posts" do
  before do
    project = FactoryGirl.create(:project)
    user = FactoryGirl.create(:user)
    define_permission!(user, "view", project)
    define_permission!(user, "create posts", project)
    @email = user.email
    sign_in_as!(user)

    visit '/'
    click_link project.name
    expect(page).to have_content("New Post")
    click_link "New Post"
  end

  scenario "Can create a Post" do
    fill_in 'Title', with: 'Bo averts disaster'
    fill_in 'Description', with: 'Bo runs to high ground'
    click_button 'Create Post'

    expect(page).to have_content('Post has been created.')

    within "#post #author" do
      expect(page).to have_content("Created by #{@email}")
    end
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

  scenario "Creating a post with an attachment" do
    fill_in "Title", with: "Add documentation for blink tag" 
    fill_in "Description", with: "The blink tag has a speed attribute"
    attach_file "File", "spec/fixtures/speed.txt"
    click_button "Create Post"

    expect(page).to have_content("Post has been created.")

    within("#post .asset") do
      expect(page).to have_content("speed.txt")
    end
  end

end

