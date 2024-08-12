# app/uploaders/avatar_uploader.rb
class AvatarUploader < CarrierWave::Uploader::Base
  # Use local file storage for development
  storage :file

  # Define a default URL if there hasn't been a file uploaded:
  def default_url(*args)
    "/images/default-avatar-7a6cbfd7993e89f24bfc888f4a035a83c6f1428b8bdc47eed9095f2799a40153.png"
  end

  # Other settings...
end