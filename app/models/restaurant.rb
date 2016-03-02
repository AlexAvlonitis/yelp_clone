class Restaurant < ActiveRecord::Base

  validates :name, length: {minimum: 3}, uniqueness: true
  has_many :reviews, dependent: :destroy
  belongs_to :user

  def build_review(attributes = {}, user)
    review = reviews.build(attributes)
    review.user = user
    review
  end
end
