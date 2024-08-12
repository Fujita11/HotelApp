class User < ApplicationRecord
  has_many :rooms, dependent: :destroy
  has_many :reservations

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader

  after_initialize :set_default_avatar, if: :new_record?
  private

  def set_default_avatar
    if self.avatar.blank?
      default_avatar_path = Rails.root.join('public', 'images', 'default-avatar-7a6cbfd7993e89f24bfc888f4a035a83c6f1428b8bdc47eed9095f2799a40153.png')
      if File.exist?(default_avatar_path)
        self.avatar = File.open(default_avatar_path)
      else
        Rails.logger.warn "Default avatar file not found: #{default_avatar_path}"
      end
    end
  end
end
