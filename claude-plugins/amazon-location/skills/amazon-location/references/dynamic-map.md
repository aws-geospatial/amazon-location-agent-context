# Dynamic Map Rendering

# Dynamic Map Display

MapLibre GL JS SHOULD be used to render Amazon Location Service maps.

Use this for:
- Interactive web maps with Amazon Location Service
- Map-based visualizations using the recommended renderer
- Location-aware applications requiring dynamic map display
- Any scenario needing MapLibre GL JS integration with Amazon Location maps

## Core Principle

**MUST use direct URL passing to MapLibre instead of GetStyleDescriptor API calls for map initialization.**

## Recommended Map Initialization

```javascript
const API_KEY = "your-api-key";
const REGION = "us-west-2";

// Direct URL method - PREFERRED
const styleUrl = `https://maps.geo.${REGION}.amazonaws.com/v2/styles/Standard/descriptor?key=${API_KEY}`;

const map = new maplibregl.Map({
    container: 'map',
    style: styleUrl,
    center: [-122.4194, 37.7749],
    zoom: 10,
    validateStyle: false, // Disable style validation for faster map load
});
```

## Additional Features

Additional map features can be enabled via the additional-features query parameter. For more details, check the geo-maps:GetStyleDescriptor documentation.

## Styles

Standard is the default style, there are other options. For more details, check the geo-maps:GetStyleDescriptor documentation.

**MUST always reference geo-maps:GetStyleDescriptor documentation for exact parameter syntax before modifying map styles.**
