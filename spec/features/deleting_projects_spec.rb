require 'spec_helper'

feature "Deleting projects" do
  scenario "Deleting a project" do
    FactoryGirl.create(:project, name: "Project to be Deleted")

    visit "/"
    click_link "Project to be Deleted"
    click_link "Delete Project"

    expect(page).to have_content("Project has been destroyed.")

    visit "/"

    expect(page).to have_no_content("Project to be Deleted")
  end
end
