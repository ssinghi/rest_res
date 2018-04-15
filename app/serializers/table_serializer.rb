class TableSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :restaurant_id
end
