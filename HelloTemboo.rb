require "temboo"
require "library/Google"
# Instantiate the Choreo, using a previously instantiated TembooSession object, eg:
session = TembooSession.new("bhubbard98", "myFirstApp", "a7214940916749afb9dc12eac861cbdd")
geocodeByAddressChoreo = Google::Geocoding::GeocodeByAddress.new(session)

# Get an InputSet object for the choreo
geocodeByAddressInputs = geocodeByAddressChoreo.new_input_set()

# Set inputs
geocodeByAddressInputs.set_Address("7339 Lagoon Blue St Las Vegas, NV 89139");

# Execute Choreo
geocodeByAddressResults = geocodeByAddressChoreo.execute(geocodeByAddressInputs)
puts "Latitude: " + geocodeByAddressResults.get_Latitude()
puts "Longitude: " + geocodeByAddressResults.get_Longitude()
