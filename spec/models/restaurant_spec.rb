require 'rails_helper'

RSpec.describe Restaurant, type: :model do
  context "validation" do
    let(:restaurant) { create(:restaurant) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to allow_values("a@a.com","123@a.in").for(:email) }
    it { is_expected.to_not allow_values("aa.com","123@ain").for(:email) }

    it { is_expected.to allow_values("1-( 234 )-567-789","567-890-123").for(:phone) }
    it { is_expected.to_not allow_values("abcdefght","abc-123-ain").for(:phone) }

    context "for email uniqueness" do
      let!(:other_restaurant) { create(:restaurant) }

      it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    end
  end
end
