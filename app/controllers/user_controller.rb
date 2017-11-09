class UserController < ApplicationController
    
  def index
    @users = User.all
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
        
        redirect_to '/user/login_true/' + user.id.to_s
      else
        redirect_to '/user/login_false'
      end
    else
      redirect_to '/user/login_false'
    end
    
  end
  
  def login_true 
    @id = params[:id]
    
    if session[:user_id]
      @email = User.find(@id).email
    end
  end
  
  def login_false
  end
  
  def logout
    id = params[:id]
    
    if session[:user_id]
      session.clear
      
      redirect_to '/'
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
