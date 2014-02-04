require 'spec_helper'

describe "Static Pages" do

  let(:base_title) {'Ruby on Rails Tutorial Sample App'}
  subject { page }

  describe "Home page" do
	before { visit root_path }
    it {should  have_title(full_title(''))}
    it {should  have_content("sample app")}
  end

  describe "Help page" do
	before{ visit help_path }
    it {should have_title(full_title('Help'))}
  end

  describe "About page" do
	before{ visit about_path }
    it {should have_title(full_title('About'))}
  end

  describe "Contact page" do
    it "should have the right title" do
      visit contact_path
      expect(page).to have_title("#{base_title} | Contact")
    end
  end


  it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About'))
    click_link "Help"
    expect(page).to have_title(full_title('Help'))
    click_link "Contact"
    expect(page).to have_title(full_title('Contact'))
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_title(full_title('Sign up'))
    click_link "sample app"
    expect(page).to have_content('Welcome')
  end


end
