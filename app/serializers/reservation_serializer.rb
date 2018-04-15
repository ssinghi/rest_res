class ReservationSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :time, :guests_count

  belongs_to :table
  belongs_to :guest
  belongs_to :shift
end
