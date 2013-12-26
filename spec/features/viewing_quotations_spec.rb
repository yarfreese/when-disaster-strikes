require 'spec_helper'

feature "Viewing quotes" do
  before do
    quotation = FactoryGirl.create(:quotation, author: "Rumi", passage: "Out beyond ideas of wrongdoing and rightdoing, there is a field.  I'll meet you there.")
   end 

  scenario "Viewing quote" do
    user = FactoryGirl.create(:user)
    sign_in_as!(user)
    visit '/'
    expect(page).to have_content("Random thoughts")
    expect(page).to have_content("Rumi")
    expect(page).to have_content("wrongdoing")
  end
end
