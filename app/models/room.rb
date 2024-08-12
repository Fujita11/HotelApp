class Room < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  
  validates :name, presence: true
  validates :description, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 1, message: "は1円以上でなければなりません" }
  validates :address, presence: true

  scope :by_area, ->(area) { where("address LIKE ?", "%#{sanitize_sql_like(area)}%") if area.present? }
  scope :search, ->(query) {
    if query.present?
      query_like = "%#{sanitize_sql_like(query)}%"
      where("name LIKE :query OR description LIKE :query OR address LIKE :query", query: query_like)
    end
  }
  has_many :reservations
end