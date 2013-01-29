//
//  GBAds.h
//  GBAds
//
//  Created by Luka Mirosevic on 28/01/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GBAdsNetworks.h"

@interface GBAds : NSObject <RevMobAdsDelegate, ChartboostDelegate>

@property (assign, nonatomic) BOOL      adsEnabled;                                             //defaults to YES
@property (assign, nonatomic) BOOL      showAdsDuringFirstSession;                              //defaults to YES

+(GBAds *)sharedAds;

-(void)connectNetwork:(GBAdsNetwork)network withCredentials:(NSString *)credentials, ...;
-(void)configureAdLogic:(GBAdsNetwork)network, ...;                                             //[[GBAds sharedAds] configureAdLogic:GBAdNetworkRevmob, GBAdNetworkRevmob, GBAdNetworkRevmob, GBAdNetworkChartboost, GBAdNetworkChartboost, 0];
-(void)showAd;

@end

/* Demo
 
 //Call this in application:didFinishLaunching:withOptions:
 [[GBAds sharedAds] connectNetwork:GBAdNetworkRevmob withCredentials:@"123"];
 [[GBAds sharedAds] connectNetwork:GBAdNetworkChartboost withCredentials:@"456", @"789"];
 [[GBAds sharedAds] configureAdLogic:GBAdNetworkRevmob, GBAdNetworkRevmob, GBAdNetworkRevmob, GBAdNetworkChartboost, GBAdNetworkChartboost, 0];

 //Call this anywhere
 [[GBAds sharedAds] showAd];
 
 Required frameworks:
 * CoreGraphics
 * CoreTelephony
 * QuartzCore
 * SystemConfiguration
 * AdSupport (optional)//foo not all
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
 
*/