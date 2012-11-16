class Punch < ActiveRecord::Base

	GEO_IP_TOOL = "http://geoiptool.com/en/?IP="

	COUNTRY_INDEX 		= 7
	CITY_INDEX 				= 13
	LONGITUDE_INDEX 	= 19
	LATITUDE_INDEX 		= 21
  
  attr_accessible :alias, :local_ip, :mac, :public_ip, 
  								:latitude, :longitude, :country, :city # APAGAR

  default_scope order: 'updated_at DESC'
	before_save :process_ip

	validates_format_of :mac, :with => /^([0-9A-F]{2}[:-]){5}([0-9A-F]{2})$/i
	validates_format_of :public_ip, :with => /^(?>(?>([a-f0-9]{1,4})(?>:(?1)){7}|(?!(?:.*[a-f0-9](?>:|$)){7,})((?1)(?>:(?1)){0,5})?::(?2)?)|(?>(?>(?1)(?>:(?1)){5}:|(?!(?:.*[a-f0-9]:){5,})(?3)?::(?>((?1)(?>:(?1)){0,3}):)?)?(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])(?>\.(?4)){3}))$/i
	validates_format_of :local_ip , :with => /^(?>(?>([a-f0-9]{1,4})(?>:(?1)){7}|(?!(?:.*[a-f0-9](?>:|$)){7,})((?1)(?>:(?1)){0,5})?::(?2)?)|(?>(?>(?1)(?>:(?1)){5}:|(?!(?:.*[a-f0-9]:){5,})(?3)?::(?>((?1)(?>:(?1)){0,3}):)?)?(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])(?>\.(?4)){3}))$/i

	private

	def process_ip
		require 'open-uri'
		page = Nokogiri::HTML(open(GEO_IP_TOOL + public_ip))
		page.css('table.tbl_style tr td').each_with_index do |row,i|
			if i == COUNTRY_INDEX
				self.country = row.content
			elsif i == CITY_INDEX
				self.city = row.content
			elsif i == LONGITUDE_INDEX
				self.longitude = row.content.to_f
			elsif i == LATITUDE_INDEX
				self.latitude = row.content.to_f
			end
		end
	end
end
