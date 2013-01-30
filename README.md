 Call this in application:didFinishLaunching:withOptions:
 [GBAds connectNetwork:GBAdNetworkRevmob withCredentials:@"123"];
 [GBAds connectNetwork:GBAdNetworkChartboost withCredentials:@"456", @"789"];
 [GBAds configureAdLogic:GBAdNetworkRevmob, GBAdNetworkRevmob, GBAdNetworkRevmob, GBAdNetworkChartboost, GBAdNetworkChartboost, 0];

 Call this anywhere
 [GBAds showAd];
 
 Required frameworks:
 * CoreGraphics
 * CoreTelephony (optional)
 * QuartzCore
 * SystemConfiguration
 * AdSupport (optional)
 * Storekit
 * CoreData
 * libz.dylib
 
 Required 3rd party frameworks (make sure project framework search path is correctly set, that framework is added to project as relative, linked against in build phases):
 * BugSense-iOS
 * RevMobAds
 
 Required libraries (add dependency, link, -ObjC linker flag, header search path in superproject):
 * GBToolbox
 * GBAnalytics
 * GBVersionTracking