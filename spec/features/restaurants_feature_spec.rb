require 'rails_helper.rb'

feature 'restaurants' do

	before do
		visit('/')
		click_link('Sign up')
		fill_in('Email', with: 'test@example.com')
		fill_in('Password', with: 'testtest')
		fill_in('Password confirmation', with: 'testtest')
		click_button('Sign up')
	end

	context 'no restaurants have been added' do
		scenario 'should desplay a prompt to add a restaurant' do
			visit('/')
			expect(page).to have_content 'No restaurant yet!'
			expect(page).to have_link 'Add a restaurant'
		end
	end

	context 'restaurants have been added' do
		before do
			Restaurant.create(name: 'KFC')
		end

		scenario 'display restaurants' do
			visit('/')
			expect(page).to have_content('KFC')
			expect(page).not_to have_content('No restaurant yet!')
		end
	end

	context 'creating restaurants' do
		scenario 'prompts user to fill out a form, then displays the new restaurant' do
			visit('/')
			click_link 'Add a restaurant'
			fill_in 'Name', with: 'KFC'
			click_button 'Create Restaurant'
			expect(page).to have_content 'KFC'
			expect(current_path).to eq '/restaurants'
		end

		scenario 'when a user is not logged in you cannot create a restaurant' do
			click_link 'Sign out'
			click_link 'Add a restaurant'
			expect(page).not_to have_content 'Add a restaurant'
			expect(page).to have_content 'Log in'
		end

		context 'an invalid restaurant' do
	    it 'does not let you submit a name that is too short' do
				visit('/')
	      click_link 'Add a restaurant'
	      fill_in 'Name', with: 'kf'
	      click_button 'Create Restaurant'
	      expect(page).not_to have_css 'h2', text: 'kf'
	      expect(page).to have_content 'error'
	    end
  	end

			it "is not valid unless it has a unique name" do
			  Restaurant.create(name: "Moe's Tavern")
			  restaurant = Restaurant.new(name: "Moe's Tavern")
			  expect(restaurant).to have(1).error_on(:name)
			end
		end

	context 'view restaurants' do
		let!(:kfc){Restaurant.create(name:'KFC')}

		scenario 'lets a user view a restaurant' do
			visit('/')
			click_link 'KFC'
			expect(page).to have_content 'KFC'
			expect(current_path).to eq "/restaurants/#{kfc.id}"
		end
	end

	context 'edit restaurants' do
		before do
			visit('/')
			click_link 'Add a restaurant'
			fill_in 'Name', with: 'Itsu'
			click_button 'Create Restaurant'
			click_link 'Sign out'
			visit('/')
			click_link('Sign up')
			fill_in('Email', with: 'testuser@example.com')
			fill_in('Password', with: 'testtest')
			fill_in('Password confirmation', with: 'testtest')
			click_button('Sign up')
			visit('/')
			click_link 'Add a restaurant'
			fill_in 'Name', with: 'KFC'
			click_button 'Create Restaurant'
		end

		scenario 'let a user edit a restaurant that they created' do
			visit('/')
			click_link 'Edit KFC'
			fill_in 'Name', with: 'Kentucky Fried Chicken'
			click_button 'Update Restaurant'
			expect(page).to have_content 'Kentucky Fried Chicken'
			expect(current_path).to eq '/restaurants'
		end

		scenario 'does not let a user edit a restaurant if they did not create it' do
			visit('/')
			click_link 'Edit Itsu'
			click_button 'Update Restaurant'
			expect(page).to have_content 'You cannot edit a restaurant that you did not create'
		end

	end

	context 'deleting restaurants' do
		before do
			visit('/')
			click_link 'Add a restaurant'
			fill_in 'Name', with: 'Itsu'
			click_button 'Create Restaurant'
			click_link 'Sign out'
			visit('/')
			click_link('Sign up')
			fill_in('Email', with: 'testuser@example.com')
			fill_in('Password', with: 'testtest')
			fill_in('Password confirmation', with: 'testtest')
			click_button('Sign up')
			visit('/')
			click_link 'Add a restaurant'
			fill_in 'Name', with: 'KFC'
			click_button 'Create Restaurant'
		end

		scenario 'removes a restaurant that they created when a user clicks a delete link' do
			visit('/')
			click_link 'Delete KFC'
			expect(page).not_to have_content 'KFC'
			expect(page).to have_content 'Restaurant deleted successfully'
		end

		scenario 'does not allow a user to delete a restaurant that they did not create' do
			visit('/')
			click_link 'Delete Itsu'
			expect(page).to have_content('Cannot delete a restaurant that you did not add')
			# expect(restaurant).to have(1).error_on(:name)
		end
	end

end
