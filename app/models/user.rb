class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :profile_image

  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy

  has_many :following_user, through: :follower, source: :followed
  has_many :follower_user, through: :followed, source: :follower


  validates :name, presence:true, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, presence:true, length: { minimum: 5, maximum: 100 }, uniqueness: false

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [100, 100]).processed
  end

  # ユーザーをフォローする
  def follow(other_user_id)
    # TODO: not working
    follower.create(followed_id: other_user_id)
  end
  # ユーザーをアンフォローする
  def unfollow(user_id)
    follower.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following_user.include?(other_user)
  end

  def followers?(other_user)
    follower_user.include?(other_user)
  end
end
