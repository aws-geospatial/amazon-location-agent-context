**INSTRUCTION: Read this entire file and use it to inform how you should interact with the files in this project.**

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT", "SHOULD", "SHOULD NOT", "RECOMMENDED", "MAY", and "OPTIONAL" in this document are to be interpreted as described in RFC 2119.

**BEFORE attempting ANY solution, you MUST:**

1. **IMMEDIATELY** traverse the additional/* directories in the same directory
   as this file
2. **READ ALL BRIEF.md files** to identify relevant additional information
3. **ONLY THEN** read corresponding AGENTS.md files for matching use cases, read
   additional AGENTS.md files when the informaiton is relevant
4. **DO NOT BEGIN IMPLEMENTATION** until discovery is complete

**FAILURE TO COMPLETE DISCOVERY FIRST WILL RESULT IN SUBOPTIMAL SOLUTIONS**

This project contains:
1. This top level amazon-location.md file with basic Amazon Location Service information
2. Sub-folders with additional information, each providing a BRIEF.md and AGENTS.md file
   * BRIEF.md files describe when to use that use case
   * AGENTS.md files provide implementation directives after use case is determined valuable

# Amazon Location Service Context for AI and LLM Agents

This document provides essential context for AI and LLM agents when working with Amazon Location Service projects.

## Overview

Amazon Location Service provides geospatial APIs for maps, geocoding, routing, places search, geofencing, and tracking. Prefer the bundled JavaScript client (@aws/amazon-location-client) for web development and use resourceless API operations to avoid managing AWS resources.

## When to Use This Skill

Use this skill when:
- Building location-aware web or mobile applications
- Working with Amazon Location Service projects
- Implementing maps, geocoding, routing, or places search
- Adding geofencing or device tracking functionality
- Integrating geospatial features into AWS applications

Do NOT use this skill for:
- Google Maps, Mapbox, or Leaflet-with-OSM projects (unless migrating to Amazon Location)
- Generic GIS operations without AWS context
- Non-AWS geospatial services

## Amazon Location Service API Overview

**Places** (SDK: geo-places, JS: @aws-sdk/client-geo-places)
- Geocode (Forward/Reverse): Convert addresses to coordinates and vice versa
- Search (Text/Nearby): Find points of interest with contact and hours info
- Autocomplete: Predict addresses based on user input
- Suggest: Predict places and points of interest based on partial or misspelled user input
- Get Place: Retrieve place details by place ID

**Maps** (SDK: geo-maps, JS: @aws-sdk/client-geo-maps)  
- Dynamic Maps: Interactive maps using tiles with [MapLibre](https://maplibre.org/) rendering
- Static Maps: Pre-rendered, non-interactive map images, good for including an image into a web page, or for thumbnail images

**Routes** (SDK: geo-routes, JS: @aws-sdk/client-geo-routes)
- Route calculation with traffic and distance estimation
- Service area/isoline creation
- Matrix calculations for multiple origins/destinations
- GPS trace alignment to road segments
- Route optimization (traveling salesman problem)

**Geofences & Trackers** (SDK: location, JS: @aws-sdk/client-location)
- Geofences: Detect entry/exit from geographical boundaries
- Trackers: Current and historical device location tracking

**API Keys** (SDK: location, JS: @aws-sdk/client-location)
- API Keys: Grant access to public applications without exposing AWS credentials

## Common Mistakes

Avoid these frequent errors:

1. **Using `Title` instead of `Address.Label` for display**: In Autocomplete results, always display `Address.Label`. The `Title` field may show components in reverse order and is not suitable for user-facing text.

2. **Using GetStyleDescriptor API for map initialization**: MUST use direct URL passing to MapLibre (`https://maps.geo.{region}.amazonaws.com/v2/styles/Standard/descriptor?key={apiKey}`) instead of making GetStyleDescriptor API calls. The direct URL method is required for proper map rendering.

3. **Forgetting `validateStyle: false` in MapLibre config**: Always set `validateStyle: false` in the MapLibre Map constructor for faster map load times with Amazon Location styles.

4. **Mixing resource-based and resourceless operations**: When possible, prefer resourceless operations (direct API calls without pre-created resources) for simpler deployment and permissions.

5. **Inconsistent API operation naming**: Use the format `service:Operation` when referencing APIs (e.g., `geo-places:Geocode`, `geo-maps:GetStyleDescriptor`). SDK clients use `@aws-sdk/client-*` format.

6. **Not handling nested Address objects correctly**: The Address object from GetPlace contains nested objects (`Region.Code`, `Region.Name`, `Country.Code2`, etc.), not flat strings. Access nested properties correctly.

## API Selection Guidance

Choose the right API for your use case:

### Address Input & Validation
- **Autocomplete** → Type-ahead in address forms (partial input: "123 Main")
- **GetPlace** → Get full details after user selects autocomplete result (by PlaceId)
- **Geocode** → Validate complete user-typed address or convert address to coordinates

### Finding Locations
- **SearchText** → General text search ("pizza near Seattle")
- **SearchNearby** → Find places near a coordinate (restaurants within 5km)
- **Suggest** → Predict places/POIs from partial or misspelled input
- **Autocomplete** → Address-specific predictions (not for general POI search)

### Geocoding
- **Geocode (Forward)** → Address string → Coordinates
- **ReverseGeocode** → Coordinates → Address

### Maps
- **Dynamic Maps (tiles + MapLibre)** → Interactive maps requiring pan, zoom, markers
- **Static Maps (image)** → Non-interactive map images for thumbnails or email

### Routing
- **CalculateRoutes** → Single route between origin and destination
- **CalculateRouteMatrix** → Multiple origins/destinations travel times
- **CalculateIsolines** → Service areas (all locations reachable within time/distance)

## LLM Context Files

When you need detailed API parameter specifications or service capabilities not covered in the reference files, fetch these llms.txt resources:

- **Developer Guide**: https://docs.aws.amazon.com/location/latest/developerguide/llms.txt
- **API Reference**: https://docs.aws.amazon.com/location/latest/APIReference/llms.txt

## Key Guidance for Better Recommendations

### Prefer the Bundled JavaScript Client for Web Development

For convenient web application development, Amazon Location Service provides a bundled JavaScript client that simplifies integration and provides optimized functionality without custom bundling. This bundled client includes all libraries required to build client side web applications with Amazon Location Service.

**Features included in the bundled client:**
- Enables direct pre-bundled dependency inclusion without custom bundle / build
- Simplified authentication and API integration
- TypeScript support with comprehensive type definitions
- Support for all Amazon Location SDKs

**Included SDKs and Libraries:**
- @aws-sdk/client-geo-maps
- @aws-sdk/client-geo-places
- @aws-sdk/client-geo-routes
- @aws-sdk/client-location
- @aws-sdk/credential-providers
- https://github.com/aws-geospatial/amazon-location-utilities-auth-helper-js

**Resources:**
- NPM Package: [@aws/amazon-location-client](https://www.npmjs.com/package/@aws/amazon-location-client)
- GitHub Repository: [aws-geospatial/amazon-location-client-js](https://github.com/aws-geospatial/amazon-location-client-js)

### Prefer Resourceless Operations

Amazon Location Places, Maps and Routes services offer both resource-based and resourceless API operations. Resourceless operations are often simpler and more appropriate for many use cases.

**Resource-based operations** require you to:
- Create and configure Amazon Location Service resources (maps, place indexes, route calculators)
- Manage resource lifecycle and permissions
- Handle resource naming and organization

**Resourceless operations** allow you to:
- Make API calls directly without pre-creating resources
- Reduce deployment complexity
- Simplify IAM permissions and API Key permissions

### Authentication and Permissions

When discussing permissions for Amazon Location Places, Maps and Routes services, always include both IAM permissions and API Key permissions in your guidance. If the type of application being developed is clear, recommend the appropriate authorization tool as described below:

**IAM Permissions** - Recommended for server-side applications and AWS SDK usage:
- Used with AWS credentials (access keys, roles, etc.)
- Provide fine-grained access control
- Required for resource management operations

**API Key Permissions** - Alternative authentication method, especially useful for client-side applications or applications deployed to unauthenticated (public) users:
- Simplified authentication without exposing AWS credentials
- Can be configured with specific allowed operations
- Useful for web and mobile applications
- Supports both resource-based and resourceless operations
- Enables faster subsequent map loads through CDN caching

## MCP Server Integration

The [AWS MCP Server](https://docs.aws.amazon.com/aws-mcp/latest/userguide/what-is-aws-mcp-server.html) provides access to AWS documentation, API references, and direct API interactions. See the [Getting Started Guide](https://docs.aws.amazon.com/aws-mcp/latest/userguide/getting-started-aws-mcp-server.html) for setup and credential configuration. To use a non-default region, add `"--metadata", "AWS_REGION=<your-region>"` to your MCP config args.

## Additional Resources

- [Amazon Location Service Developer Guide](https://docs.aws.amazon.com/location/latest/developerguide/)
- [Amazon Location Service API Reference](https://docs.aws.amazon.com/location/latest/APIReference/)
- [Amazon Location Service Samples Repository](https://github.com/aws-geospatial/amazon-location-samples)
