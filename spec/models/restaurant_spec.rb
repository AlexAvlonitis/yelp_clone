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
end
