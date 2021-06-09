# AppCenter Plugin for flutter

======

This is updated plugin currently bundles appcenter analytics, crashes and distribute.

[original pub
](https://pub.dev/packages/flutter_appcenter_bundle)
## Getting Started

To get started, go to [AppCenter](https://appcenter.ms/apps) and register your apps.

For detailed AppCenter API reference, go to https://aka.ms/appcenterdocs

## Usage

### Basic usage

```dart
import 'package:flutter_appcenter_bundle/flutter_appcenter_bundle.dart';

await AppCenter.startAsync(
    appSecretAndroid: '******',
    appSecretIOS: '******',
    enableAnalytics: true, // Defaults to true
    enableCrashes: true, // Defaults to true
    enableDistribute: true, // Defaults to false
    usePrivateDistributeTrack: false, // Defaults to false
    disableAutomaticCheckForUpdate: false, // Defaults to false
  );
  
AppCenter.trackEventAsync('my event', <String, String> {
  'prop1': 'prop1',
  'prop2': 'prop2',
});
```

### Turn feature on / off at runtime

```dart
await AppCenter.configureAnalyticsAsync(enabled: true);

await AppCenter.configureCrashesAsync(enabled: true);

await AppCenter.configureDistributeAsync(enabled: true);

await AppCenter.configureDistributeDebugAsync(enabled: true); // Android Only

await AppCenter.checkForUpdateAsync(); // Manually check for update
```
