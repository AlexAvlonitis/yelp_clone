module Helper

  def signup(email: "", password: "")
    visit('/')
		click_link('Sign up')
		fill_in('Email', with: email)
		fill_in('Password', with: password)
		fill_in('Password confirmation', with: password)
		click_button('Sign up')
  end

  def add_restaurant(name: "")
    click_link 'Add a restaurant'
    fill_in 'Name', with: name
    click_button 'Create Restaurant'
  end

  def add_review(thoughts: "", review: 1)
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: thoughts
    select review, from: 'Rating'
    click_button 'Leave Review'
  end

end
