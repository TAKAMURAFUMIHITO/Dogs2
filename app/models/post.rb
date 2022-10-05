class Post < ApplicationRecord

  belongs_to :member
  has_many :likes, dependent: :destroy

  validates :title, length: { minimum: 2, maximum: 30 }, presence: true
  has_one_attached :post_image

  def get_post_image
    if post_image.attached?
      post_image
    end
  end

  def liked_by?(member)
    likes.exists?(member_id: member.id)
  end
end
