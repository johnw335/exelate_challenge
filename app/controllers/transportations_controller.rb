class TransportationsController < ApplicationController

    def index
      @xml_scrape = Transportation.new

      # puts "This is the original scrape"
      # puts @xml_scrape

      # puts "This is attempt at finding lines"
      # puts @lines
      # @print_class_list = @xml_scrape.get_class_items('line')
      # puts @print_class_list

      @timestamp = @xml_scrape.get_timestamp.inner_html


      @subway_line_names = @xml_scrape.list_subway_lines
      # puts @subway_line_names

      # @bus_line_names = @xml_scrape.list_bus_lines
      # puts @bus_line_names

      # @bt_line_names = @xml_scrape.list_bt_lines
      # puts @bt_line_names

      # @lirr_line_names = @xml_scrape.list_lirr_lines
      # puts @lirr_line_names

      # @metroNorth_line_names = @xml_scrape.list_metroNorth_lines
      # puts @metroNorth_line_names

      @transportation_list = Transportation.all
      @user = User.find(session[:current_user_id])
      @user_favorites = Favorite.where(user: @user)
      @favorite_status_array = []
      @favorite_name_array = []
      @user_favorites.each do |t|
        @favorite_name_array << t.transportation.name
      end
      @user_favorites.each do |favorite|
        @favorite_name = favorite.transportation.name
        @favorite_type = favorite.transportation.transport_type
      @favorite_status_array << @xml_scrape.individual_transport_status(@favorite_type, @favorite_name )
      end
      @full_info_array = []
      i = 0
      while i < @favorite_name_array.length
        new_array = []
        new_array << @favorite_name_array[i]
        new_array << @favorite_status_array[i]
        @full_info_array << new_array
        i += 1
      end



    end

    def display

      @xml_scrape = Transportation.new

      @transport_type = params[:transportation][:transport_type]

      @subway_lines = @xml_scrape.list_subway_lines

      @user = User.find(session[:current_user_id])

      if @transport_type == 'bus'
        @transport_list = @xml_scrape.transport_status('bus')
        @bus_lines = @xml_scrape.list_bus_lines
        @zipped_hash = Hash[@transport_list.zip @bus_lines]
      elsif @transport_type == 'subway'
        @transport_list = @xml_scrape.transport_status('subway')
        @subway_lines = @xml_scrape.list_subway_lines
        @zipped_hash = Hash[@transport_list.zip @subway_lines]
      elsif @transport_type == 'bt'
        @transport_list = @xml_scrape.transport_status('bt')
        @bt_lines = @xml_scrape.list_bt_lines
        @zipped_hash = Hash[@transport_list.zip @bt_lines]
      elsif @transport_type == 'lirr'
        @transport_list = @xml_scrape.transport_status('lirr')
        @lirr_lines = @xml_scrape.list_lirr_lines
        @zipped_hash = Hash[@transport_list.zip @lirr_lines]
      elsif @transport_type == 'metro north'
        @transport_list = @xml_scrape.transport_status('metronorth')
        @metro_north_lines = @xml_scrape.list_metroNorth_lines
        @zipped_hash = Hash[@transport_list.zip @metro_north_lines]
      else
        puts "you chose somethigng else"
      end
    end

    def show
      redirect_to 'transportations/display'
    end

end
