require 'rails_helper'

describe Restaurant, type: :model do
  it { should have_many(:reviews).dependent(:destroy) }

  it 'is not valid with a name of less than three characters' do
    restaurant = Restaurant.new(name: "kf")
    expect(restaurant).to have(1).error_on(:name)
    expect(restaurant).not_to be_valid
  end

  it 'is not valid unless it has a unique name' do
    Restaurant.create(name: "nandos")
    restaurant = Restaurant.new(name: "nandos")
    expect(restaurant).to have(1).error_on(:name)
  end

  describe '#average_rating' do

    context 'no reviews' do
      it 'returns "N/A" when there are no reviews' do
        restaurant = Restaurant.create(name: 'The Ivy')
        expect(restaurant.average_rating).to eq 'N/A'
      end
    end

    context '1 review' do
      it 'returns that rating' do
        restaurant = Restaurant.create(name: 'The Ivy')
        restaurant.reviews.create(rating: 4)
        expect(restaurant.average_rating).to eq 4
      end
    end

    context 'multiple reviews' do
      it 'returns the average' do
        user = User.create(email: "asd@asd.com", password: "password123")
        user2 = User.create(email: "assdd@asd.com", password: "password123")
        user.restaurants.create(name: 'pret')
        restaurant = Restaurant.find_by(name: 'pret')
        restaurant.reviews.create(rating: 1, user: user)
        restaurant.reviews.create(rating: 5, user: user2)
        expect(restaurant.average_rating).to eq 3
      end
    end

  end

end
