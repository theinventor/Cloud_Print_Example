class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :trackable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  #TODO - needs fields here to store auth token, refresh token, whatever
  attr_accessible :email, :name, :provider, :uid

  has_many :user_accounts
  has_many :printers

  def self.create_with_omniauth(auth)
    @user = self.new
    @user.email = auth[:extra][:raw_info][:email]
    @user.name  = auth[:info][:name]
    @user if @user.add_account(auth)
  end

  def add_account(auth)
    @account = self.user_accounts.find_or_initialize_by_uid( auth[:uid], :email =>  auth[:extra][:raw_info][:email],
                                    :provider => auth[:provider], 
                                    :refresh_token => auth[:credentials][:refresh_token] )
    self.save
  end

  

  
end
