//
//  GBAds.m
//  GBAds
//
//  Created by Luka Mirosevic on 28/01/2013.
//  Copyright (c) 2013 Goonbee. All rights reserved.
//

#import "GBAds.h"

static NSString *kGBAdCredentialsRevmobAppID = @"kGBAdCredentialsRevmobAppID";

static NSString *kGBAdCredentialsChartboostAppID = @"kGBAdCredentialsChartboostAppID";
static NSString *kGBAdCredentialsChartboostAppSignature = @"kGBAdCredentialsChartboostAppSignature";

static NSString *kGBAdCredentialsTapjoyAppID = @"kGBAdCredentialsTapjoyAppID";
static NSString *kGBAdCredentialsTapjoySecret = @"kGBAdCredentialsTapjoySecret";


@interface GBAds ()

@property (strong, nonatomic) NSMutableDictionary                   *connectedAdNetworks;
@property (strong, nonatomic) NSMutableArray                        *adLogic;
@property (assign, nonatomic) BOOL                                  isInProcess;
@property (assign, nonatomic) NSUInteger                            nextAttempt;
@property (assign, nonatomic) BOOL                                  enableDebugLogging;

//Ad network specific
@property (strong, nonatomic) RevMobFullscreen                      *revmobAd;

@end


@implementation GBAds

#pragma mark - Storage

_singleton(GBAds, sharedAds)
_lazy(NSMutableDictionary, connectedAdNetworks, _connectedAdNetworks)
_lazy(NSMutableArray, adLogic, _adLogic)

#pragma mark - Initialiser

-(id)init {
    if (self = [super init]) {
        self.adsEnabled = YES;
        self.showAdsDuringFirstSession = YES;
        self.nextAttempt = 0;
        self.enableDebugLogging = NO;
    }
    
    return self;
}

#pragma mark - Public API

+(void)connectNetwork:(GBAdsNetwork)network withCredentials:(NSString *)credentials, ... {
    [self _debugLogConnectNetwork:network];
    
    va_list args;
    va_start(args, credentials);
    
    switch (network) {
        case GBAdNetworkRevmob: {
            if (IsValidString(credentials)) {
                [GBAds sharedAds].connectedAdNetworks[@(GBAdNetworkRevmob)] = @{kGBAdCredentialsRevmobAppID: credentials};
                
                [RevMobAds startSessionWithAppID:[GBAds sharedAds].connectedAdNetworks[@(GBAdNetworkRevmob)][kGBAdCredentialsRevmobAppID]];
            }
            else {
                NSAssert(NO, @"GBAds: Didn't pass valid credentials for Revmob");
            }
        } break;
            
        case GBAdNetworkChartboost: {
            NSString *appID = credentials;
            NSString *appSignature = va_arg(args, NSString *);
            
            if (IsValidString(appID) && IsValidString(appSignature)) {
                [GBAds sharedAds].connectedAdNetworks[@(GBAdNetworkChartboost)] = @{kGBAdCredentialsChartboostAppID: appID, kGBAdCredentialsChartboostAppSignature: appSignature};
                
                [Chartboost sharedChartboost].appId = appID;
                [Chartboost sharedChartboost].appSignature = appSignature;
                [[Chartboost sharedChartboost] startSession];
            }
            else {
                NSAssert(NO, @"GBAds: Didn't pass valid credentials for Chartboost");
            }
            
        } break;
            
        case GBAdNetworkTapjoy: {
            NSString *appID = credentials;
            NSString *secret = va_arg(args, NSString *);
            
            if (IsValidString(appID) && IsValidString(secret)) {
                [GBAds sharedAds].connectedAdNetworks[@(GBAdNetworkTapjoy)] = @{kGBAdCredentialsTapjoyAppID: appID, kGBAdCredentialsTapjoySecret: secret};
                
                [TapjoyConnect requestTapjoyConnect:appID secretKey:secret];
            }
            else {
                NSAssert(NO, @"GBAds: Didn't pass valid credentials for Chartboost");
            }
            
        } break;
                    
        default:
            return;
    }
    
    va_end(args);
}

+(void)configureAdLogic:(GBAdsNetwork)network, ... {
    [[GBAds sharedAds].adLogic removeAllObjects];
    
    va_list args;
    va_start(args, network);
    
    for (GBAdsNetwork adNetwork = network; adNetwork != 0; adNetwork = va_arg(args, GBAdsNetwork)) {
        [[GBAds sharedAds].adLogic addObject:@(adNetwork)];
    }
    
    va_end(args);
}

+(void)showAd {
    if (![GBAds sharedAds].isInProcess && [GBAds sharedAds].adsEnabled && !([GBVersionTracking isFirstLaunchEver] && ([GBAds sharedAds].showAdsDuringFirstSession == NO))) {
        //reset next
        [GBAds sharedAds].nextAttempt = 0;
        
        //execute first ad code
        [[GBAds sharedAds] _attemptToShowNextAd];
    }
}

#pragma mark - Private

-(void)_attemptToShowNextAd {
    //if theres no attempts remaining, return early
    if (self.adLogic.count <= self.nextAttempt) {
        _t(@"GBAds: Not showing ad");
        self.isInProcess = NO;
        return;
    }
    
    //find out which ad to show and then show it
    GBAdsNetwork network = [self.adLogic[self.nextAttempt] intValue];
    
    //increment next attempt before doing anything else to prevent infinite loops if the subsequently calling code would cause this method to be called in the current run loop
    self.nextAttempt += 1;
    
    switch (network) {
        case GBAdNetworkRevmob: {
            if (self.connectedAdNetworks[@(GBAdNetworkRevmob)]) {
                self.revmobAd = [[RevMobAds session] fullscreen];
                self.revmobAd.delegate = self;
                [self.revmobAd loadAd];
            }
            else {
                l(@"GBAds: Connect to Revmob first!");
                
                [self _internalFail];
            }
        } break;
            
        case GBAdNetworkChartboost: {
            if (self.connectedAdNetworks[@(GBAdNetworkChartboost)]) {
                [Chartboost sharedChartboost].delegate = self;
                [[Chartboost sharedChartboost] showInterstitial];
            }
            else {
                l(@"GBAds: Connect to Chartboost first!");
                
                [self _internalFail];
            }
        } break;
            
        case GBAdNetworkTapjoy: {
            if (self.connectedAdNetworks[@(GBAdNetworkTapjoy)]) {
                l(@"GBAds: Tapjoy ads not implemented");
            }
            else {
                l(@"GBAds: Connect to Chartboost first!");
                
                [self _internalFail];
            }
        } break;
            
        default:
            break;
    }
}

-(void)_adSuccess {
    _t(@"GBAds: Showing ad");
    self.isInProcess = NO;
}

-(void)_adFail {
    _t(@"GBAds: Ad failed attempt");
    [self _attemptToShowNextAd];
}

#pragma mark - Revmob delegate

-(void)revmobAdDidReceive {
    [self.revmobAd showAd];
}

- (void)revmobAdDisplayed {
    _t(@"GBAds: Revmob Success");
    [self _adSuccess];
}

- (void)revmobAdDidFailWithError:(NSError *)error {
    _t(@"GBAds: Revmob Fail");
    [self _adFail];
}

#pragma mark - Chartboost delegate

-(BOOL)shouldDisplayInterstitial:(NSString *)location {
    _t(@"GBAds: Chartboost Success");
    [self _adSuccess];
    
    return YES;
}

-(void)didFailToLoadInterstitial:(NSString *)location {
    _t(@"GBAds: Chartboost Fail");
    [self _adFail];
}

#pragma mark - Internal pseudo-delegate

-(void)_internalFail {
    _t(@"GBAds: Internal Fail");
    [self _adFail];
}

#pragma mark - Debug Logging

+(void)enableDebug:(BOOL)enable {
    [GBAds sharedAds].enableDebugLogging = enable;
}

+(void)_debugLogConnectNetwork:(GBAdsNetwork)network {
    if ([GBAds sharedAds].enableDebugLogging) {
        NSString *networkName;
        
        switch (network) {
            case GBAdNetworkRevmob:
                networkName = @"Revmob";
                break;
                
            case GBAdNetworkChartboost:
                networkName = @"Chartboost";
                break;
                
            case GBAdNetworkTapjoy:
                networkName = @"Tapjoy";
                break;
                
            default:
                networkName = @"Unkown Network";
                break;
        }
        
        l(@"GBAds Log: connected to ad network: %@", networkName);
    }
}

@end
