class User < ActiveRecord::Base
  #TODO - needs fields here to store auth token, refresh token, whatever
  attr_accessible :email, :name, :provider, :uid

  def self.create_with_omniauth(auth)
    @user = self.new
    @user.email = auth[:extra][:raw_info][:email]
    @user.name  = auth[:info][:name]
    @user.uid   = auth[:uid]
    @user.provider =  auth[:provider]
    @user if @user.save
  end
end
