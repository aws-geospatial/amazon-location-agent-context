# Address Verification

When provided with a complete but unconfirmed address, geo-places:Geocode MAY be used to confirm the structure and validity of the input address. This is useful when taking input from users before the data is persisted to a database.

## API Used

### Geocode
- Match the provided input to an address in the confirmed address database
- Provide additional information about the matched address
- Provide standardized formatting of the address for display or storage
- Look up the position (coordinates) of an address

## Best Practices

- Always validate addresses before persisting to database
- Use standardized format from geocoding response
- Store coordinates for future use (maps, routing)
- Handle edge cases (PO boxes, rural addresses)
