class FavoritesController < ApplicationController

  def create
    @line_name = params[:name]
    @line = Transportation.find_by(name: @line_name)

    @user = User.find(session[:current_user_id])

   @fave_exist = Favorite.find_by(user: @user, transportation: @line)
   if @fave_exist
      puts "That favorite already exists"
    else
      puts "thats a new favorite"
      @newFavorite = Favorite.create!(user: @user, transportation: @line)
    end
    redirect_to transportations_path
  end








  def destroy
    @user = User.find(session[:current_user_id])
    @line_name = params[:name]
    @line = Transportation.find_by(name: @line_name)
    @favorite = Favorite.find_by(user: @user, transportation: @line)
    Favorite.destroy(@favorite)
    redirect_to transportations_path


  end


end
