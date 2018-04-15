require 'rails_helper'

RSpec.describe Api::RestaurantsController, type: :controller do
  describe "GET #reservations" do
    let!(:shift) { create(:shift) }
    let!(:reservations) { create_list(:reservation, 3, shift: shift) }
    let(:parsed_response) { JSON.parse(response.body) }

    before do
      get :reservations, params: {id: shift.restaurant.id }
    end

    it "response should be success" do
      expect(response).to be_success
    end

    it "should return all restaurants" do
      expect(parsed_response['data'].length).to eq(reservations.count)
    end
  end
end
