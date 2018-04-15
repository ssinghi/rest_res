class ShiftSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :start_time, :end_time, :restaurant_id
end
