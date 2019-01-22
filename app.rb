require 'bundler'
require 'csv'
require 'json'
require 'google_drive'
Bundler.require
require_relative 'lib/scrapper'
@listmail = Scrapper.new
@list = @listmail.get_townhall_urls
def save_as_JSON
	File.open("/db/list.json","w") do |f|
    f.write(JSON.pretty_generate(@list))
	end	
end
def save_as_spreadsheet
	session = GoogleDrive::Session.from_config("config.json")
session.files.each do |file|
  	p file.title
			end
session.upload_from_file("/db/list.json", "list.json", convert: false)
end
def save_as_csv
CSV.open("/db/list.csv", "w") do |csv|
  csv << @list
	end	
end
save_as_JSON
save_as_csv
save_as_spreadsheet
