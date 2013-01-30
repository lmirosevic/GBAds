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

+(void)connectNetwork:(GBAdsNetwork)network withCredentials:(NSString *)credentials, ...;
+(void)configureAdLogic:(GBAdsNetwork)network, ...;                                             //[GBAds configureAdLogic:GBAdNetworkRevmob, GBAdNetworkRevmob, GBAdNetworkRevmob, GBAdNetworkChartboost, GBAdNetworkChartboost, 0];
+(void)showAd;

+(void)enableDebug:(BOOL)enable;

@end