class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:access_token] = auth[:credentials][:token]
    session[:refresh_token] = auth[:credentials][:refresh_token]
    session[:code] = params[:code]
    session[:state] = params[:state]
    session[:user_id] = user.id

    redirect_to root_url, :notice => "Signed in!"
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end
