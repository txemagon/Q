class Acronym < ActiveRecord::Base

	validates :key,  uniqueness: true
	validates :name, uniqueness: true

    # Makes the canonical version of an acronym
    #     "  H.O. L. A . N " => "holan"
	def self.normalize word
		word.gsub(/\s*\.\s*/, '').strip.downcase
	end

	# Returns de acronym with interleaved dots
	#     "eso" => E.S.O.
    def self.acronym(word)
    	word.gsub(/\w/) { |l| l.upcase + '.' }
    end


	def acronym
       self.class.acronym(self.key)
	end

end
