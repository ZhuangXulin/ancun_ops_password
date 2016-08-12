class Users::SessionsController < Devise::SessionsController

# before_filter :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end


  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end

  #用户登录接口
  #Request:: 
  # - curl -H 'Content-Type: application/json'   -H 'Accept: application/json' -X POST http://ip:port/users/sign_in.json   -d '{"user": {"email": "?", "password": "?"}}'
  #Return::
  # - result:true or false
  # - errorCode:0 is true,1 is the account is not exists,2 is the username or password input nil
  # - message:error's message
  # - username:signup's username/email
  # - uid:user id
  # - ut:user token
  def create
    # 验证邮箱是否存在
    user = User.find_for_database_authentication(:email => params[:user][:email])
    respond_to do |format|
      if !user
        Email.login_unsucessful_email(params[:user][:email],request.remote_ip).deliver_now
        format.html { redirect_to user_session_path, :notice => 'User was Login Unsuccessfully.' }
      else
        #验证密码是否正确
        if user.valid_password?(params[:user][:password])
          Email.login_email(current_user.email,current_user.current_sign_in_ip).deliver_now
          sign_in("user", user)
          format.html { redirect_to acsystem_index_path, :notice => 'User was Login Successfully.' }
        else
          Email.login_unsucessful_email(params[:user][:email],request.remote_ip).deliver_now
          format.html { redirect_to user_session_path, :notice => 'User was Login Unsuccessfully.' }
        end
      end
    end
  end

  # DELETE /resource/sign_out
  def destroy
    sign_out(current_user)
    respond_to do |format|
      format.html{
        redirect_to user_session_path, :notice => 'User was Logout Successfully.' 
      }
    end
  end

end
