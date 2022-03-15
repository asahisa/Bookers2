class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  ## パスワードの正確性
  devise :database_authenticatable,
  ## ユーザー登録、情報編集、削除
  :registerable,
  ## パスワードのリセット
  :recoverable,
  ## ログイン情報の保存
  :rememberable,
  ## バリテーション設定
  :validatable
  
  ## 1:Nの親設定
  has_many :book, dependent: :destroy
  
  ## プロフィール画像
  has_one_attached :profile_image
  
  ## バリテーション設定
  validates :name, length: { minimum: 2 }
  
  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

end
