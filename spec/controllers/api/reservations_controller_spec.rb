require 'rails_helper'

RSpec.describe Api::ReservationsController, type: :controller do
  describe "POST #create" do
    let(:shift) { create(:shift) }
    let(:guest) { create(:guest) }
    let(:table) { create(:table, restaurant: shift.restaurant) }
    let(:time)  { shift.start_time.change(year: Time.zone.today.year, month: Time.zone.today.month, day: Time.zone.today.day) }
    let(:parsed_response) { JSON.parse(response.body) }

    it "should create reservation" do
      expect {
        post :create, params: { reservation: { guest_id: guest, table_id: table, guests_count: table.min_guests,
                                               shift_id: shift, time: time } }
      }.to change { Reservation.count }.by(1)

      expect(response.status).to eq(201)
      expect(parsed_response["data"]["attributes"]["guests_count"]).to equal(table.min_guests)
      expect(Time.parse(parsed_response["data"]["attributes"]["time"])).to eq(time)
      expect(parsed_response["data"]["relationships"]["table"]["data"]["id"]).to eq(table.id.to_s)
      expect(parsed_response["data"]["relationships"]["shift"]["data"]["id"]).to eq(shift.id.to_s)
      expect(parsed_response["data"]["relationships"]["guest"]["data"]["id"]).to eq(guest.id.to_s)
    end

    it "should not create reservation" do
      expect {
        post :create, params: { reservation: { guest_id: guest, table_id: table, guests_count: table.min_guests, shift_id: shift } }
      }.to_not change { Reservation.count }
      expect(response.status).to eq(422)
    end
  end

  describe "PATCH #update" do
    let(:reservation) { create(:reservation) }
    let(:parsed_response) { JSON.parse(response.body) }

    it "should update reservation" do
      patch :update, params: { id: reservation.id,
                               reservation: { guests_count: reservation.guests_count + 1, time: reservation.time + 1.hour } }
      expect(response.status).to eq(200)
      expect(parsed_response["data"]["attributes"]["guests_count"]).to equal(reservation.guests_count + 1)
      expect(Time.parse(parsed_response["data"]["attributes"]["time"])).to eq(reservation.time + 1.hour)
    end

    it "should not update reservation" do
      patch :update, params: { id: reservation.id,
                               reservation: { guests_count: reservation.guests_count + 100 } }
      expect(response.status).to eq(422)
    end
  end
end
