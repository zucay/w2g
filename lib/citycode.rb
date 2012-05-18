# -*- Coding: utf-8 -*-
$citycodeFile = "now1108.txt"

class Citycode
	attr_accessor :prefCodes
	def initialize()
		@prefCodes = Hash.new
		@city2pref = Hash.new
		cityCodePath = File.dirname(__FILE__) + "/" + $citycodeFile
		#p cityCodePath
		fi = open(cityCodePath)
		fi.each do |line|
			row = line.chomp.split(",")
			if(!@prefCodes[row[2]])
				@prefCodes[row[2]] = []
			end
			@prefCodes[row[2]] << row
			
			#市区町村から都道府県へのHash
			[row[3], row[4]].each do |city|
				if(!@city2pref[city])
					@city2pref[city] = []
				end
				@city2pref[city] << row[2]
				@city2pref[city].uniq!
			end
		end
	end
	
	def splitKen(addr)
		out = nil
		if(addr =~ /^(北海道|京都府|大阪府|東京都)/)
			out  = $1
		elsif(addr =~ /^(.{1,3}県)/ )
			#p "KEN!"
			#sleep(0.2)
			out = $1
		end
		return out
	end
	
	def getCodeAndSplitAddr(addr)
		out = [nil, nil, nil, addr] 
    addr ||= ''
		addr = addr.gsub(/\s/, "")
		addr = addr.gsub(/\t/, "")
		addr = addr.gsub(/　/, "")
		pref = splitKen(addr)
		if(@prefCodes[pref])
			@prefCodes[pref].each do |row|
				city = "#{row[2]}#{row[3]}#{row[4]}"
				if(addr =~ /#{city}(.*)/)
					#コード、都道府県、市区町村、残り住所の配列
					out = [row[1], row[2], "#{row[3]}　#{row[4]}", $1]
					out[2].gsub!(/　$/, '')
					break
				end
			end
		else
			#県名がない場合、「市」があればば全都道府県から探す。ただし府中市・伊達市はダブってるので外す。
			#todo: 適当過ぎ。「ひたちなか市」などに対応していない。
			#getPrefFromCityというメソッドを作ったので、乗り換えるように修正が必要。obsolate
			if(addr =~ /\w{1,4}市/)
				if(addr =~ /(府中市|伊達市)/)
				else
					#p addr
					@prefCodes.each do |citiesH|
						citiesH[1].each do |row|
							city = "#{row[2]}#{row[3]}#{row[4]}"
							if(addr =~ /#{city}(.*)/)
								#コード、都道府県、市区町村、残り住所の配列
								out = [row[1], row[2], "#{row[3]}　#{row[4]}", $1]
								break
							end
						end
					end
				end
			end
		end
		
		return out
	end
  def splitAddr(str)
    arr = getCodeAndSplitAddr(str)
    return([arr[1], arr[2], arr[3]])
  end
	
	def getCodeFromFile(file, toFile)
		out = []
		fi = open(file)
		fi.each do |line|
			code = getCodeAndSplitAddr(line.chomp)[0]
			#p code
			out << code
		end
		
		fo = open(toFile, 'w')
		out.each do |o|
			fo.print(o)
			fo.print("\n")
		end
		fo.close
	end
	
	#市・郡名から一意に県名がわかる場合、県名を返却する
	#うるま市→沖縄県　[OK]
	#府中市→東京都・広島県　[NG]
	#北区→[NG]
	def getPrefFromCity(str)
		out = nil
		prefs = @city2pref[str]
		if(prefs && prefs.size == 1)
			out = prefs[0]
		end
		return out
	end
end

if($0 == __FILE__)
	c = Citycode.new
	c.getCodeFromFile("addr.txt", "addr_citycode.txt")
end
