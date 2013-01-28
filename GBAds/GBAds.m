//
//  GBAds.m
//  GBAds
//
//  Created by Luka Mirosevic on 28/01/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import "GBAds.h"

static NSString *kAdNetworkRevmob = @"AdNetworkRevmob";
static NSString *kAdCredentialsRevmobAppID = @"kAdCredentialsRevmobAppID";

static NSString *kAdNetworkChartboost = @"AdNetworkChartboost";
static NSString *kAdCredentialsChartboostAppID = @"kAdCredentialsChartboostAppID";
static NSString *kAdCredentialsChartboostAppSignature = @"kAdCredentialsChartboostAppSignature";

@interface GBAds ()

@property (strong, nonatomic) NSMutableDictionary *enabledAdNetworks;
@property (strong, nonatomic) NSMutableArray *adLogic;

@end


@implementation GBAds

#pragma mark - Storage

_singleton(GBAds, sharedAds)
_lazy(NSMutableDictionary, enabledAdNetworks, _enabledAdNetworks)
_lazy(NSMutableArray, adLogic, _adLogic)

#pragma mark - Public API

-(void)connectNetwork:(GBAdsNetwork)network withCredentials:(NSString *)credentials, ... {
    switch (network) {
        case GBAdNetworkRevmob: {
            if (IsValidString(credentials)) {
                self.enabledAdNetworks[kAdNetworkRevmob] = @{kAdCredentialsRevmobAppID: credentials};
            }
            else {
                NSAssert(NO, @"GBAds: Didn't pass valid credentials for Revmob");
            }
        } break;
            
        case GBAdNetworkChartboost: {
            va_list args;
            va_start(args, credentials);
            
            NSString *appID = credentials;
            NSString *appSignature = va_arg(args, NSString *);

            va_end(args);
            
            if (IsValidString(appID) && IsValidString(appSignature)) {
                self.enabledAdNetworks[kAdNetworkChartboost] = @{kAdCredentialsChartboostAppID: appID, kAdCredentialsChartboostAppSignature: appSignature};
            }
            else {
                NSAssert(NO, @"GBAds: Didn't pass valid credentials for Chartboost");
            }
            
        } break;
            
            
        default:
            return;
    }
}

-(void)configureAdLogic:(GBAdsNetwork)network, ... {
    [self.adLogic removeAllObjects];
    
    va_list args;
    va_start(args, network);
    
    for (GBAdsNetwork adNetwork = network; adNetwork != 0; adNetwork = va_arg(args, GBAdsNetwork)) {
        [self.adLogic addObject:@(adNetwork)];
    }
    
    va_end(args);
}

-(void)showAd {
    //get the enabled networks
    //get the ad logic and make sure it doesnt reference any network which isnt enabled
    
    //execute ad code in the appropriate order
}

@end
