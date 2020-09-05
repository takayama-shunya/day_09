class SessionsController < ApplicationController

  skip_before_action :authenticate_user
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
      # ログイン成功した場合
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
      # ログイン失敗した場合
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path
  end
end
