---
name: Amazon Location Service
description: Add location and geospatial context to applications with mapping, address lookup, geofence evaluation and more. Use when working with Amazon Location Service projects involving maps, geocoding, routing, places, geofencing, or tracking.
---

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

## LLM Context Files

Amazon Location Service provides structured context files specifically designed for AI and LLMs following the llms.txt standard:

- **Developer Guide Context**: https://docs.aws.amazon.com/location/latest/developerguide/llms.txt - Overview of Amazon Location Service concepts, features, and developer guidance
- **API Reference Context**: https://docs.aws.amazon.com/location/latest/APIReference/llms.txt - Structured information about all available Amazon Location Service APIs and operations

These context files should be used to get an accurate overview of what is available in Amazon Location Service and to ensure responses are based on current service capabilities.

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

## Recommended MCP Server

For LLM clients that support Model Context Protocol (MCP), the unified [AWS MCP Server](https://docs.aws.amazon.com/aws-mcp/latest/userguide/what-is-aws-mcp-server.html) provides access to AWS documentation, API references, best practices, and direct AWS API interactions. It subsumes the functionality of the previous `aws-api-mcp-server` and `aws-knowledge-mcp-server`.

**Setup:** See the [AWS MCP Server Getting Started Guide](https://docs.aws.amazon.com/aws-mcp/latest/userguide/getting-started-aws-mcp-server.html) for configuration instructions. By default, AWS operations use `us-east-1`. To change the default region, add `"--metadata", "AWS_REGION=<your-region>"` to the args in your MCP config. You can also override per-query by specifying a region in your prompt.

### Troubleshooting AWS Credentials

The AWS MCP Server requires valid AWS credentials to authenticate requests. If you encounter authentication errors:

1. **Verify credentials are configured** by running:
   ```
   aws sts get-caller-identity
   ```
   If this fails, configure credentials using one of:
   - `aws login` (recommended for console users, requires AWS CLI 2.32.0+)
   - `aws configure sso` (for SSO users)
   - `aws configure` (for IAM users with access keys)

2. **Refresh expired credentials**: If authentication previously worked but now fails, your credentials may have expired. Re-run the login command for your authentication method.

3. **Verify IAM permissions**: If not using an administrator role, ensure your IAM user or role has the required permissions:
   ```json
   {
     "Version": "2012-10-17",
     "Statement": [{
       "Effect": "Allow",
       "Action": [
         "aws-mcp:InvokeMcp",
         "aws-mcp:CallReadOnlyTool",
         "aws-mcp:CallReadWriteTool"
       ],
       "Resource": "*"
     }]
   }
   ```

4. **Install uv** (required for the MCP proxy): If `uvx` is not found, install it with:
   - macOS/Linux: `curl -LsSf https://astral.sh/uv/install.sh | sh`
   - Windows: `powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"`

## Additional Resources

- [Amazon Location Service Developer Guide](https://docs.aws.amazon.com/location/latest/developerguide/)
- [Amazon Location Service API Reference](https://docs.aws.amazon.com/location/latest/APIReference/)
- [Amazon Location Service Samples Repository](https://github.com/aws-geospatial/amazon-location-samples)

## Reference Files

Load these resources as needed for specific implementation guidance:

- [Address Input](./references/address-input.md) - Create effective address input forms for users with address type ahead completion improving input speed and accuracy
- [Address Verification](./references/address-verification.md) - Validate addresses input from users before taking actions or persisting to databases
- [Dynamic Map Rendering](./references/dynamic-map.md) - Render dynamic maps with MapLibre
- [Places Search](./references/places-search.md) - Search for places or points of interest
- [Web JavaScript](./references/web-javascript.md) - Integrate Amazon Location services into web browser applications

