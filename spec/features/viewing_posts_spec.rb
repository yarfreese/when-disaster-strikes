require 'spec_helper'

feature "Viewing posts" do
  before do
    user = FactoryGirl.create(:user)
    sign_in_as!(user)
    choking = FactoryGirl.create(:project, name: "Choking")
    define_permission!(user, "view", choking)
    post = FactoryGirl.create(:post, project: choking, title: "heimlich",
           description: "Bo gets the heimlich")
    post.update(user: user)

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
