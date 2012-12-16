class User < ActiveRecord::Base
  #TODO - needs fields here to store auth token, refresh token, whatever
  attr_accessible :email, :name
end
