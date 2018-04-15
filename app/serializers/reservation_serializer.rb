class ReservationSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :table_id, :table_name, :guest_name, :time, :guests_count
end
