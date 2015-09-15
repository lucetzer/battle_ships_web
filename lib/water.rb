class Water

	attr_reader :hit

	def initialize
		@hit = false
	end

	def hit!
		@hit = true
	end

	def hit?
		@hit
	end
end
