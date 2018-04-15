require 'rails_helper'

RSpec.describe ReservationMailer, type: :mailer do
  let(:reservation)  { create(:reservation) }

  describe "#email_guest" do
    let(:mail)  { described_class.email_guest(reservation) }

    it "renders headers" do
      expect(mail.to).to eq([reservation.guest.email])
      expect(mail.subject).to eq("Reservation confirmed for #{reservation.restaurant.name}.")
    end

    it "deliver email" do
      expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  describe "#email_restaurant" do
    let(:mail)  { described_class.email_restaurant(reservation) }

    it "renders headers" do
      expect(mail.subject).to eq("Reservation #{reservation.id} for #{reservation.guest.name}.")
      expect(mail.to).to eq([reservation.restaurant.email])
    end

    it "deliver email" do
      expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end

  describe "#email_guest_with_updates" do
    let(:mail)  { described_class.email_guest_with_updates(reservation, {}) }

    it "renders headers" do
      expect(mail.to).to eq([reservation.guest.email])
      expect(mail.subject).to eq("Reservation updated for #{reservation.restaurant.name}.")
    end

    it "deliver email" do
      expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
