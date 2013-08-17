require 'spec_helper'

feature "Deleting projects" do
  scenario "Deleting projects" do
    FactoryGirl.create(:project, name: "Delete This Project")

    visit "/"
    click_link "Delete This Project"
    click_link "Delete Project"
   
    expect(page).to have_content ("Project has been destroyed.")

    visit "/"

    expect(page).to have_no_content("Delete This Project")
  end
end
