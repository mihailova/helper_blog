class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :registerable, :recoverable, :token_authenticatable, :encryptable, 
  # :validatable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable

  has_many :posts
  has_many :comments, dependent: :destroy

  has_many :changed_posts, class_name: "Post", foreign_key: :last_editor_id
end
