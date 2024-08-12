class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :room

  validates :check_in_date, presence: true
  validates :check_out_date, presence: true
  validates :number_of_guests, presence: true, numericality: { greater_than_or_equal_to: 1 }

  validate :check_in_date_cannot_be_in_the_past
  validate :check_out_date_must_be_after_check_in_date

  def total_price
    number_of_nights = (check_out_date - check_in_date).to_i
    room.price * number_of_nights * number_of_guests
  end

  private

  def check_in_date_cannot_be_in_the_past
    if check_in_date.present? && check_in_date < Date.today
      errors.add(:check_in_date, "は今日以降の日付にしてください")
    end
  end

  def check_out_date_must_be_after_check_in_date
    if check_out_date.present? && check_out_date <= check_in_date
      errors.add(:check_out_date, "はチェックイン日より後の日付にしてください")
    end
  end
end
