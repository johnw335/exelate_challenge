require 'nokogiri'
require 'open-uri'
require 'uri'

@url = 'http://mta.info/status/serviceStatus.txt'
@doc = Nokogiri::HTML(open(@url))


testUser1 = User.create!(email: "test@email.com", password: "password")



@subway_lines = @doc.xpath("//subway//line//name")

i = 0
while i < 11
  Transportation.create!(transport_type: "subway", name: @subway_lines[i].inner_html.to_s)
  i += 1
end
puts "I got here 2"

@bus_lines = @doc.xpath("//bus//line//name")
i = 0
while i < 10
  Transportation.create!(transport_type: "bus", name: @bus_lines[i].inner_html.to_s)
  i += 1
end


@bt_lines = @doc.xpath("//bt//line//name")
i = 0
while i < 9
  Transportation.create!(transport_type: "bt", name: @bt_lines[i].inner_html.to_s)
  i += 1
end

@lirr_lines = @doc.xpath("//lirr//line//name")
i = 0
while i < 11
  Transportation.create!(transport_type: "lirr", name: @lirr_lines[i].inner_html.to_s)
  i += 1
end

@metroNorth_lines = @doc.xpath("//metronorth//line//name")
i = 0
while i < 9
  Transportation.create!(transport_type: "metro north", name: @metroNorth_lines[i].inner_html.to_s)
  i += 1
end

test_transport = Transportation.find(1)

Favorite.create!(user: testUser1, transportation: test_transport)