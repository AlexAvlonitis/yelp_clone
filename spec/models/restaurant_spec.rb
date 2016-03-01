require 'rails_helper'

describe Restaurant, type: :model do
  it { should have_many(:reviews).dependent(:destroy) }
end
