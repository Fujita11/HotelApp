class ReservationsController < ApplicationController
  before_action :set_room, only: %i[new create confirm]
  before_action :set_reservation, only: %i[show confirm complete destroy cancel]

  def cancel
    @reservation.destroy
    redirect_to reservations_path, notice: '予約がキャンセルされました。'
  end

  def index
    @reservations = current_user.reservations
  end

  def show
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = @room.reservations.build(reservation_params)
    @reservation.user = current_user

    if @reservation.save
      redirect_to confirm_room_reservation_path(@room, @reservation), notice: '予約が確定しました。'
    else
      render 'rooms/show'
    end
  end

  def edit
  end

  def update
    if @reservation.update(reservation_params)
      redirect_to reservation_path(@reservation), notice: '予約が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    @reservation.destroy
    redirect_to reservations_path, notice: '予約がキャンセルされました。'
  end

  def confirm
    @total_payment_amount = calculate_total_price(@reservation)
  end

  def complete
    if @reservation.update(status: 'confirmed')
      redirect_to reservations_path, notice: '予約が完了しました。'
    else
      redirect_to confirm_room_reservation_path(@room, @reservation), alert: '予約の確定に失敗しました。'
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:check_in_date, :check_out_date, :number_of_guests)
  end

  def set_room
    @room = Room.find(params[:room_id])
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def calculate_total_price(reservation)
    return 0 unless reservation.room && reservation.check_in_date && reservation.check_out_date
    number_of_nights = (reservation.check_out_date - reservation.check_in_date).to_i
    number_of_nights * reservation.room.price * reservation.number_of_guests
  end
end