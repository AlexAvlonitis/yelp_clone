class Restaurant < ActiveRecord::Base

  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/100px-No_image_available.svg.png"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates :name, length: {minimum: 3}, uniqueness: true
  has_many :reviews, dependent: :destroy
  belongs_to :user

  def build_review(attributes = {}, user)
    review = reviews.build(attributes)
    review.user = user
    review
  end

  def average_rating
    return 'N/A' if reviews.none?
    reviews.average(:rating)
  end
end
