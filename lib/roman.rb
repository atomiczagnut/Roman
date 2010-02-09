=begin
	A ruby library for handling roman numerals
	By Colin Trierweiler
	Available under the GNU GPL
=end

#Associate the letters and the numbers

RomNum = { 1 => "I", 5 => "V", 10 => "X", 50 => "L", 100 => "C", 500 => "D", 1000 => "M" }

class Fixnum

	#Convert ints into strings of roman numerals

	def toRoman
		raise "Inupt must be an integer between 1 and 4999" unless (1..4999) === self 
		roman = ""
		num = self
		until num <= 0
			RomNum.keys.sort.reverse.each do |sub|
				while num >= sub
					roman << RomNum[sub]
					num -= sub
				end
				next
			end
		end
		roman.modernize!
		return roman
	end
end

class String

	#Convert strings of roman numerals into ints

	def toArabic
		num = 0
		roman = self.upcase
		roman.ancientify!
		until roman == ""
			num += RomNum.index(roman[-1..-1])
			roman.chop!
		end
		return num
	end


	#Transform ancient style into modern style destructively

	def modernize!
		self.gsub!("DCCCC", "CM")
		self.gsub!("CCCC", "CD")
		self.gsub!("LXXXX", "XC")
		self.gsub!("XXXX", "XL")
		self.gsub!("VIIII", "IX")
		self.gsub!("IIII", "IV")
	end

	#Transform modern style into ancient style destructively

	def ancientify!
		self.gsub!("CM", "DCCCC")
		self.gsub!("CD", "CCCC")
		self.gsub!("XC", "LXXXX")
		self.gsub!("XL", "XXXX")
		self.gsub!("IX", "VIIII")
		self.gsub!("IV", "IIII")
	end

	#Without the modernize! method, strings would consist of ancient style roman numerals
	#instead of the subtractive modern style, i.e. "IIII" instead of "IV".
	#Without the ancientify! method, transforming modern strings into ints would be far more complicated.
	#I prefer the destructive methods (no need for a middleman), 
	#but I've included non-destructive methods for thouroughness.

	#Transform ancient style into modern style

	def modernize
		roman = self
		roman.gsub("DCCCC", "CM")
		roman.gsub("CCCC", "CD")
		roman.gsub("LXXXX", "XC")
		roman.gsub("XXXX", "XL")
		roman.gsub("VIIII", "IX")
		roman.gsub("IIII", "IV")
	end

	#Transform modern style into ancient style 

	def ancientify
		roman = self
		roman.gsub("CM", "DCCCC")
		roman.gsub("CD", "CCCC")
		roman.gsub("XC", "LXXXX")
		roman.gsub("XL", "XXXX")
		roman.gsub("IX", "VIIII")
		roman.gsub("IV", "IIII")
	end


end

