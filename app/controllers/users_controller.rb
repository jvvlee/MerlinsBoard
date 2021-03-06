class UsersController < ApplicationController
  #wrap_parameters false

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user) #sets session token and current user
      redirect_to root_url
    else
      flash.now[:errors] = @user.errors.full_messages #this is already an array
      render :new #local can get passed in automatically through partial?
    end
  end

  private

  def user_params
    #params are the response from the form
    params.require(:user).permit(:fname,:lname,:password,:email, :avatar)
  end
end
