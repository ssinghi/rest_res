class RestaurantSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :phone, :email
end
