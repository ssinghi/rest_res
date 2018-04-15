require 'rails_helper'

RSpec.describe Api::ReservationsController, type: :controller do
  describe "POST #create" do
    let(:shift) { create(:shift) }
    let(:guest) { create(:guest) }
    let(:table) { create(:table, restaurant: shift.restaurant) }
    let(:time)  { shift.start_time.change(year: Time.zone.today.year, month: Time.zone.today.month, day: Time.zone.today.day) }

    it "should create reservation" do
      post :create, params: { reservation: { guest_id: guest, table_id: table, guests_count: table.min_guests,
                                             shift_id: shift, time: time } }
      expect(response.status).to eq(201)
    end

    it "should not create reservation" do
      post :create, params: { reservation: { guest_id: guest, table_id: table, guests_count: table.min_guests, shift_id: shift } }
      expect(response.status).to eq(422)
    end
  end

  describe "PATCH #update" do
    let(:reservation) { create(:reservation) }

    it "should update reservation" do
      patch :update, params: { id: reservation.id,
                               reservation: { guests_count: reservation.guests_count + 1, time: reservation.time + 1.hour } }
      expect(response.status).to eq(200)
    end

    it "should not update reservation" do
      patch :update, params: { id: reservation.id,
                               reservation: { guests_count: reservation.guests_count + 100 } }
      expect(response.status).to eq(422)
    end
  end
end
