//
//  GBAdsNetworks.h
//  GBAds
//
//  Created by Luka Mirosevic on 28/01/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import <ChartBoost/Chartboost.h>
#import <Tapjoy/Tapjoy.h>
#import <RevMobAds/RevMobAds.h>

typedef enum {
    GBAdNetworkRevmob = 1,
    GBAdNetworkChartboost,
    GBAdNetworkTapjoy,
} GBAdsNetwork;


/* Networks
 
 RevMob
   Params: RevmobAppID
   Example: [GBAds connectNetwork:GBAdNetworkRevmob withCredentials:@"RevmobAppID"];
 
 Chartboost
   Params: ChartboostAppID, ChartboostAppSig
   Example: [GBAds connectNetwork:GBAdNetworkChartboost withCredentials:@"ChartboostAppID", @"ChartboostAppSig"];
 
 Tapjoy
   Params: TapjoyAppId, TapjoySecret
   Example: [GBAds connectNetwork:GBAdNetworkTapjoy withCredentials:@"TapjoyAppId", @"TapjoySecret"];
 
 */
