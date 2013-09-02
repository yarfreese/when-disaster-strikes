require 'spec_helper'

feature "Viewing projects" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:project) { FactoryGirl.create(:project, name: "Hidden") }
  let!(:project_2) { FactoryGirl.create(:project, name: "TextMate 2") }

  before do
    sign_in_as!(user)
    define_permission!(user, :view, project_2)
  end

  scenario "Listing all projects" do
    visit '/'
    page.should_not have_content("Hidden")
    click_link 'TextMate 2'
    expect(page.current_url).to eql(project_url(project_2))
  end
end

