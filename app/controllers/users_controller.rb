class UsersController < ApplicationController

  def login
    puts "email"
    @email = params[:user][:email]
    puts 'password'
    puts params[:user][:password]

    @user = User.find_by(email: @email)

    if @user
      session[:current_user_id] = @user.id
      redirect_to transportations_path
    else
      flash.now[:error] = "Sorry that user doesnt exist"
    end


  end

  def create
    @email = params[:user][:email]
    @password = params[:user][:password]
    @user = User.find_by(email: @email)


    if @user
      puts "sorry that user already exits"
    else
      @user = User.create!(email: @email, password: @password)
      session[:current_user_id] = @user.id
      redirect_to transportations_path
    end


  end


end
