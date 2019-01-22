require 'nokogiri'
require 'open-uri'
require 'time'
require 'pry'

class Scrapper
	def get_townhall_email(townhall_url)

	doc = Nokogiri::HTML(open(townhall_url))

	doc.search('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each do |link|
  		return link.content
		end
	end
	def get_townhall_urls
	town1=[]
	town=[]
	mail=[]	
	hash_contact={}
	i=0
	page = Nokogiri::HTML(open('http://www.annuaire-des-mairies.com/val-d-oise.html'))
	page.xpath('//a[@class="lientxt"]/@href').each do |x| 
	town << x.text
		end
	page.xpath('//a[@class="lientxt"]/text()').each do |y| 
	town1 << y.text
		end
	j=town.length
		while i<j
		mail[i]= get_townhall_email( "http://annuaire-des-mairies.com/#{town[i]}")
		i+=1	
		end
	hash_contact=[town1.zip(mail)]
	end
end