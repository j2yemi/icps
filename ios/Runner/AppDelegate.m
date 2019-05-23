#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "GoogleMaps/GoogleMaps.h"


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GMSServices provideAPIKey:@"AIzaSyDke97c3YgVWs_b0HXatPyfpvvlIWzeVM8"];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  GeneratedPluginRegistrant.register(with: flutterViewController.pluginRegistry());
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
