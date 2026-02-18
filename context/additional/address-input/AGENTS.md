# Address Input

Address input forms SHOULD make use of geo-places:Autocomplete for type ahead completion of partially typed addresses. When an autocomplete result is selected the form SHOULD use geo-places:GetPlace to confirm the entry and populate complete information. If no result from autocomplete is selected by the user, the final input should be verified with geo-places:Geocode.

## APIs Used

### Autocomplete
- Complete a partially input address
- Provide suggested addresses for partially typed addresses in an address form
- **IMPORTANT**: Always use `Address.Label` for display, NOT `Title`. The `Title` field may be in reverse order

### GetPlace
- Retrieve complete place details by PlaceId
- **Address Structure**: The Address object contains nested objects:
  - `Region`: Object with `Code` (state code like "TX") and `Name` (full name like "Texas")
  - `Country`: Object with `Code2` (2-letter like "US"), `Code3` (3-letter like "USA"), and `Name` (full name)
  - `Locality`: String (city name)
  - `PostalCode`: String
  - `Street`: String
  - `AddressNumber`: String

### Geocode
- Match the provided input to an address in the confirmed address database
- Provide additional information about the matched address
- Provide standardized formatting of the address for display or storage
