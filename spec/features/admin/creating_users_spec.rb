require 'spec_helper'

feature "Creating Users" do
  let!(:admin) { FactoryGirl.create(:admin_user) }
  user = FactoryGirl.create(:user, name: "factorygirl", email: "fg@example.com")

  before do
    sign_in_as!(admin)
    visit '/'
    click_link "Admin"
    click_link "Users"
  end

  scenario 'Viewing a user' do
    visit user_path(user) 
    expect(page).to have_content(user.name) 
    expect(page).to have_content(user.email) 
  end

  scenario 'Creating a new user' do
    click_link "New User"
    fill_in "Email", with: "newbie@example.com"
    fill_in "user_password", with: "password"
    fill_in "user_password_confirmation", with: "password"
    click_button "Create User"
    expect(page).to have_content("User has been created.")
  end
end

