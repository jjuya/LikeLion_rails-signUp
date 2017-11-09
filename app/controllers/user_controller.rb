class UserController < ApplicationController
    
  def index
    @users = User.all
      
    if session[:user_id] == 3
      @email = User.find(3).email
    end
  end
  
  def new
  end
    
  def create
    require 'digest'

    @user_email = params[:user_email]
    @user_password = params[:user_password]
    
    hidden_password = Digest::MD5.hexdigest(@user_password)
        
      User.create(
          email: @user_email,
          password: hidden_password
      )
  end
    
  def login
  end
  
  def login_process
    require 'digest'
    
    if User.exists?(email: params[:user_email])
      
      user = User.find_by(email: params[:user_email])
      
      if user.password == Digest::MD5.hexdigest(params[:user_password])
        session[:user_id] = user.id
        
        redirect_to '/'
      end
    end
    
  end
    
  def modify
        
    user_id = params[:id]
        
    @user = User.find(user_id)
  end
    
  def update
    user_id = params[:id]
      
    user = User.find(user_id)
      
    user.update(
      email: params[:email],
      password: params[:password],
    )
        
    redirect_to '/'
  end
    
  def destroy
    user_id = params[:id]
        
    User.destroy(user_id)
        
    redirect_to '/'
  end
    
end
