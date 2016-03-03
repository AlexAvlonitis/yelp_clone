require 'rails_helper'
require_relative 'web_helper'

feature 'reviewing' do
  include Helper
  before {Restaurant.create name: 'KFC'}

  scenario 'allows users to leave a review using a form' do
    signup(email: "asd@asd.com", password: "password123")
    add_review(thoughts: 'so so')

    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'user cannot review a restaurant twice' do
    signup(email: "asd@asd.com", password: "password123")
    add_review(thoughts: 'so so')
    add_review(thoughts: 'asd')
    expect(page).not_to have_content('asd')
    expect(page).to have_content('You have already reviewed this restaurant')
  end

end
