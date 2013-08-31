require 'spec_helper'

feature 'Deleting users' do
  let!(:admin_user) { FactoryGirl.create(:admin_user) }
  let!(:user) { FactoryGirl.create(:user) }

  before do
    sign_in_as!(admin_user)
    visit '/'

    click_link 'Admin'
    click_link 'Users'
  end

  scenario "Deleting a user" do
    click_link user.email
    click_link 'Delete User'

    expect(page).to have_content("User has been deleted")
    expect(page).to_not have_content(user.email)
  end

  scenario "Cannot delete yourself" do
    click_link admin_user.email
    click_link 'Delete User'

    expect(page).to have_content("You cannot delete yourself!")
    expect(page).to have_content(admin_user.email)
  end
end
