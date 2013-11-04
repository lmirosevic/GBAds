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

//Basic API
+(void)connectNetwork:(GBAdsNetwork)network withCredentials:(NSString *)credentials, ...;
+(void)configureAdLogic:(GBAdsNetwork)network, ... NS_REQUIRES_NIL_TERMINATION;                                             //[GBAds configureAdLogic:GBAdNetworkRevmob, GBAdNetworkRevmob, GBAdNetworkRevmob, GBAdNetworkChartboost, GBAdNetworkChartboost, nil];
+(void)showAd;

//Options
+(void)enableDebug:(BOOL)enable;                //defaults to NO
+(void)enableAds:(BOOL)enable;                  //defaults to YES
+(void)showAdsDuringFirstSession:(BOOL)enable;  //defaults to YES

@end