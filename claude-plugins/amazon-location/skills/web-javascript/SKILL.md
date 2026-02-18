---
name: Web JavaScript
description: Integrate Amazon Location services into web browser applications
---

# Web Application Integration

When building web applications, the javascript AWS SDK SHOULD be used. For Amazon Location Service, a bundled SDK with support for places, routes, maps, tracking, geofencing and additional authorization helpers is available.

npm package: @aws/amazon-location-client

## Import

```html
<script src="https://cdn.jsdelivr.net/npm/@aws/amazon-location-client@1"></script>
```

All functions available under `amazonLocationClient` global.

## Authentication

### API Key
```javascript
const authHelper = amazonLocationClient.withAPIKey("<API Key>", "<Region>");
```

### Cognito
```javascript
const authHelper = await amazonLocationClient.withIdentityPoolId("<Identity Pool ID>");
```

## Client Usage

### client-geo-places
```javascript
const client = new amazonLocationClient.GeoPlacesClient(authHelper.getClientConfig());
const command = new amazonLocationClient.places.GetPlaceCommand(input);
const response = await client.send(command);
```

### client-geo-maps
```javascript
const client = new amazonLocationClient.GeoMapsClient(authHelper.getClientConfig());
const command = new amazonLocationClient.maps.GetStaticMapCommand(input);
const response = await client.send(command);
```

### client-geo-routes
```javascript
const client = new amazonLocationClient.GeoRoutesClient(authHelper.getClientConfig());
const command = new amazonLocationClient.routes.CalculateRoutesCommand(input);
const response = await client.send(command);
```

### client-location
```javascript
const client = new amazonLocationClient.LocationClient(authHelper.getClientConfig());
const command = new amazonLocationClient.ListGeofencesCommand(input);
const response = await client.send(command);
```

## Pattern
1. Create auth helper with API key or Cognito
2. Create client with `authHelper.getClientConfig()`
3. Create command with input parameters
4. Send command and await response
