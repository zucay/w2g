# -*- coding: utf-8 -*-  
require 'open-uri'
require 'json'
require 'uri'
class Restproc
	#url is like 'http://192.168.88.4000/ipc2jgd.json'
	def initialize(url, parser_path=nil)
		@baseurl = url
		@parser_path = parser_path
		if(parser_path)
			load('parser_path')
		end
	end
	def call(method,hash)    
		args = []
		hash.each_pair do |k,v|
      ev = URI.escape(v)
			args << "#{k}=#{ev}"
		end
		arg = args.join('&')
    methUrl = URI.join(@baseurl, method).to_s    
		url = URI.join(methUrl, "?#{arg}").to_s
		res = open(url).read
		out = JSON.parse(res)
		return out        
	end
end