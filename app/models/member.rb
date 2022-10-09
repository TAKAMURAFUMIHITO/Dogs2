class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :relationships, foreign_key: :follower_id, dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :followed_id, dependent: :destroy
  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_of_relationships, source: :follower
  has_many :comments, dependent: :destroy
  has_many :entries, dependent: :destroy

  validates :name, length: { minimum: 2, maximum: 20 }, presence: true
  has_one_attached :profile_image

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no-image.PNG'
  end

  def follow(member)
    relationships.create(followed_id: member.id)
  end

  def unfollow(member)
    relationships.find_by(followed_id: member.id).destroy
  end

  def following?(member)
    followings.include?(member)
  end

  def self.looks(search, word)
    @member = Member.where("name LIKE?","%#{word}%")  #部分一致のみ
  end
end
