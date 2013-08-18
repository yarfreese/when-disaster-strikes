require 'spec_helper'

feature "Viewing tickets" do
  before do
    choking = FactoryGirl.create(:project, name: "Choking")
    FactoryGirl.create(:post, project: choking, title: "heimlich",
           description: "Bo gets the heimlich")

    falling = FactoryGirl.create(:project, name: "Falling")
    FactoryGirl.create(:post, project: falling, title: "maximum area - spread out",
           description: "Bo doesn't like this one")

    visit '/'
  end

  scenario "Viewing posts for a given project" do
    click_link "Choking"

    expect(page).to have_content("heimlich")
    expect(page).to_not have_content("maximum area - spread out")

    click_link "heimlich"
    within("#post h2") do
      expect(page).to have_content("heimlich")
    end

    expect(page).to have_content("Bo gets the heimlich")
  end
end
