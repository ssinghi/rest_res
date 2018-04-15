require 'rails_helper'

RSpec.describe Guest, type: :model do
  context "validations" do
    let!(:guest) { create(:guest) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to allow_values("a@a.com","123@a.in").for(:email) }
    it { is_expected.to_not allow_values("aa.com","123@ain").for(:email) }

    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  end
end
