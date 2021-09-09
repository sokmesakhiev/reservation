class GuestSerializer
  include FastJsonapi::ObjectSerializer
  set_type :guest

  attributes :first_name, :last_name, :email, :phone
end
