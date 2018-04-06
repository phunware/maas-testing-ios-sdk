# PWCore Migration Guide
## Upgrade from 3.1.x to 3.3.0

#### General

This release has some changes to support our new Location BLE provider.

#### Upgrade Steps

1. Open the `Podfile` from your project and change PWCore to include `pod 'PWCore', '3.3.0'`, then run `pod update` in the Terminal to update the framework. This is only necessary if using PWCore by itself. Otherwise the correct version will be installed with PWLocation/PWMapKit or PWEngagement if using it bundled.
