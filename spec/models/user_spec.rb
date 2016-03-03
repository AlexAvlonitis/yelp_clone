require 'rails_helper'

describe User, type: :model do
  it { should have_many :reviewed_restaurants}
  it { should have_many :reviews}
  it { should have_many :restaurants}
end
