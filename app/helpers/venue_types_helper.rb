module VenueTypesHelper
	def name_column(r)
		r.name rescue 'unknown VT name'
	end
end
