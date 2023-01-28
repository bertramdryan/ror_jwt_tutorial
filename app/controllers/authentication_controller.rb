class AuthenticationController < ApplicationController
  skip_before_action :authenicate_user
  # post /auth/login
  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenicate(params[:password])
      token = Jwtoken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
