class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    # userが存在していて(trueで)、パスワードが一致しているなら
    if user && user.authenticate(params[:session][:password])
      # 親クラスのApplicationContollerのinclude SessionsHelperのlog_inメソッドを使った
      log_in user
      # userページに飛ぶ
      redirect_to user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
