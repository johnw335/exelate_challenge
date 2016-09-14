class SessionsController < ApplicationController

  def create
    session[:current_user_id] = @user.id
    puts session[:current_user_id]
    puts 'this is tehe sessions create path"'
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
