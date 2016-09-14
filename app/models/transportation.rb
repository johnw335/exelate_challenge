class Transportation < ApplicationRecord
  has_many :favorites
  require 'nokogiri'
  require 'open-uri'
  require 'uri'

  attr_reader :url, :data

  def initialize
    @url = 'http://mta.info/status/serviceStatus.txt'

    @doc = Nokogiri::HTML(open(@url))
  end

  def get_timestamp
    @timestamp = @doc.xpath("//timestamp")
  end

  def list_subway_lines
     @subway_lines = @doc.xpath("//subway//line//name")
  end

  def subway_status
    @subway_status = @doc.xpath("//subway//line//status")
  end

  def list_bus_lines
     @bus_lines = @doc.xpath("//bus//line//name")
  end

  def transport_status(transport)
    if transport == "metro north"
      transport = "metronorth"
    end
    @status_array = @doc.xpath("//#{transport}//line//status")
  end

  def list_lines(transport)
    if transport == "metro north"
      transport = "metronorth"
    end
    @lines = @doc.xpath("//#{transport}//line//name")
  end

  def individual_transport_status(transport_type, name)
    @transport_name_array = []
    @transport_list = transport_status(transport_type)
    @transport_list.each do |t|
      @transport_name_array << t.inner_html
    end

    @transport_service_array = []
    @lines = list_lines(transport_type)
    @lines.each do |l|
      @transport_service_array << l.inner_html
    end
    @zipped_hash = Hash[@transport_service_array.zip @transport_name_array]
    return @zipped_hash[name]
  end

  def list_bt_lines
     @bt_lines = @doc.xpath("//bt//line//name")
  end

  def list_lirr_lines
     @lirr_lines = @doc.xpath("//lirr//line//name")
  end

   def list_metroNorth_lines
     @metroNorth_lines = @doc.xpath("//metronorth//line//name")
  end

  def get_class_items(class_name)
    @class_finder = @doc.xpath("//#{class_name}//name")
  end



end
