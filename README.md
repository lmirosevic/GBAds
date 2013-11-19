GBAds
============

Abstracts away different interstitial ad network implementations and implements simple mediation logic for maximising fill rates

Supported networks
------------

* RevMob
* Chartboost
* Tapjoy (currently install tracking only)

Usage
------------

First import header:

```objective-c
#import "GBAds.h"
```

Connect to any networks you may want to mediate between in `application:didFinishLaunching:withOptions:`

```objective-c
//Connect RevMob
[GBAds connectNetwork:GBAdNetworkRevmob withCredentials:@"RevmobAppID"];

//Connect Chartboost
[GBAds connectNetwork:GBAdNetworkChartboost withCredentials:@"ChartboostAppID", @"ChartboostAppSig"];

//Connect Tapjoy
[GBAds connectNetwork:GBAdNetworkTapjoy withCredentials:@"TapjoyAppId", @"TapjoySecret"];
```

Configure mediation (fallback) logic. In this case the library will attempt to load an ad from revmob 3 times, and then twice from chartboost. Only 1 ad is ever shown and this just defines a fallback scheme. Terminate list with 0!

```objective-c
[GBAds configureAdLogic:GBAdNetworkRevmob, GBAdNetworkRevmob, GBAdNetworkRevmob, GBAdNetworkChartboost, GBAdNetworkChartboost, 0];
```

Show an ad, call this anywhere:

```objective-c
[GBAds showAd];
```

Options:

```objective-c
[GBAds enableDebug:YES];				//prints debug info to console, defaults to NO
[GBAds enableAds:NO];					//temporarily lets you enable/disable ads, e.g. while during an in-app flow, defaults to YES. If this is set to NO, then [GBAds showAd] does nothing.
[GBAds showAdsDuringFirstSession:NO];	//Allows you to specify whether or not to show an ad on the first ever app launch, defaults to YES
```

Dependencies
------------

Static libraries (Add dependency, link, -ObjC linker flag, header search path in superproject):

* [GBToolbox](https://github.com/lmirosevic/GBToolbox)
* [GBAnalytics](https://github.com/lmirosevic/GBAnalytics)
* [GBVersionTracking](https://github.com/lmirosevic/GBVersionTracking)

System Frameworks (link them in):

* CoreGraphics
* CoreTelephony (optional)
* QuartzCore
* SystemConfiguration
* AdSupport (optional)
* Storekit
* CoreData
* libz.dylib

3rd party frameworks included (make sure project framework search path is correctly set, that framework is added to project as relative link, linked against in build phases of superproject):
* BugSense-iOS
* RevMobAds

Copyright & License
------------

Copyright 2013 Luka Mirosevic

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this work except in compliance with the License. You may obtain a copy of the License in the LICENSE file, or at:

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/lmirosevic/gbads/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
