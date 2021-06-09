#import "AppCenterBundleSdkPlugin.h"
#if __has_include(<flutter_appcenter/flutter_appcenter-Swift.h>)
#import <flutter_appcenter/flutter_appcenter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_appcenter-Swift.h"
#endif

@implementation AppCenterBundleSdkPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAppCenterBundleSdkPlugin registerWithRegistrar:registrar];
}
@end
