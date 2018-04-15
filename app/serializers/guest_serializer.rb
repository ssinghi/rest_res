class GuestSerializer
  include FastJsonapi::ObjectSerializer

  attributes :id, :name, :email
end
