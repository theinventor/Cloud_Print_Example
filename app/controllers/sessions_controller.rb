class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    if current_user # adding another account
      @user = current_user
      @user.add_account(auth)
      redirect_to printers_path
    else
      user = UserAccount.find_by_provider_and_uid(auth["provider"], auth["uid"]).user rescue User.create_with_omniauth(auth)
      session[:access_token] = auth[:credentials][:token]
      session[:refresh_token] = auth[:credentials][:refresh_token]
      session[:code] = params[:code]
      session[:state] = params[:state]
      sign_in(user)
      redirect_to printers_path
    end
  end

  def new
  end

  def destroy
    sign_out(current_user)
    redirect_to root_url, :notice => "Signed out!"
  end

end
