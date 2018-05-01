require 'rails_helper'

RSpec.feature "UserLogins", type: :feature do
      #SETUP
      before :each do
          @user = User.create!(
            name: "test user",
            email: "test@test.test",
            password: "test",
            password_confirmation: "test"
          )
      end  


    scenario "User logs in with valid credentials" do
      visit login_path
      within 'form' do
        fill_in id: 'email', with: @user.email
        fill_in id: 'password', with: @user.password
        click_button 'Submit'
      end
      expect(page).to have_content 'Logout'

    end
end
