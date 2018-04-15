require 'rails_helper'

RSpec.describe Api::RestaurantsController, type: :controller do
  describe "GET #reservations" do
    let!(:shift) { create(:shift) }
    let!(:reservations) { create_list(:reservation, 150, shift: shift) }
    let(:parsed_response) { JSON.parse(response.body) }

    before do
      get :reservations, params: {id: shift.restaurant.id }
    end

    it "response should be success" do
      expect(response).to be_successful
      expect(parsed_response["meta"]["total"]).to equal(reservations.count)
      expect(parsed_response["data"].size).to equal(parsed_response["meta"]["per_page"])
      expect(parsed_response["included"]).to_not be_empty
    end
  end
end
