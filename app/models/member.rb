class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post
  has_many :post_comments, dependent: :destroy
  has_many :events, dependent: :destroy

  # 自分がフォローする側の関係
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 自分がフォローされる側の関係
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :following, through: :relationships, source: :followed
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower

  validates :name, presence: true

  # フォローするとき
  def follow(member)
    relationships.create(followed_id: member.id)
  end
  # フォローを外すとき
  def unfollow(member)
    relationships.find_by(followed_id: member.id).destroy
  end
  # フォローしているか確認するとき
  def following?(member)
    following.include?(member)
  end

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |member|
    member.password = SecureRandom.urlsafe_base64
    member.name = "ゲスト"
    end
  end
end