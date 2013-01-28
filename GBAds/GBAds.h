//
//  GBAds.h
//  GBAds
//
//  Created by Luka Mirosevic on 28/01/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GBAdsNetworks.h"

@interface GBAds : NSObject

+(GBAds *)sharedAds;

-(void)connectNetwork:(GBAdsNetwork)network withCredentials:(NSString *)credentials, ...;
-(void)configureAdLogic:(GBAdsNetwork)network, ...; //0 terminated
-(void)showAd;


//-(void)setAdLogic:(NSDictionary *)adLogic; //@[@(GBAdNetworkRevmob), @(GBAdNetworkRevmob), @(GBAdNetworkRevmob), @(GBAdNetworkChartboost)]

@end
