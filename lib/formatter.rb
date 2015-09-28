class Formatter

	LOWERCASE = %w/ a ante bajo cabe con contra de desde en entre
	hacia hasta para por según si so sobre tras
	el la lo las los
	y e o u
	ni que
	/

	def self.add_acronym(data={})
		Acronym.delete_all
		data.each do |key, expand|
			Acronym.create(
				:key  => key,
				:name => Acronym.acronym(key),
				:expand => Formatter.show(expand)
				)
		end
	end

    def self.capitalize(word)
    	if LOWERCASE.include? word.downcase
    		word
    	else
			word.capitalize
		end
    end

	def self.sentence(text)
		words = text.humanize.downcase
	end

	def self.show(words)
		words.humanize.split.map { |w| Formatter.word(w) }.join(' ')
	end

	def self.word(text)
		text = text.to_s.downcase
		if acr = Acronym.find_by(key: text)
		    acr.acronym
		else
			self.capitalize(text)
		end
	end

end