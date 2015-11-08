//Copyright (c) 2014 Sang Ki Kwon (Cranberrygame)
//Email: cranberrygame@yahoo.com
//Homepage: http://cranberrygame.github.io
//License: MIT (http://opensource.org/licenses/MIT)
#import "AdBuddizPlugin.h"
//
#import <AdBuddiz/AdBuddiz.h>
#import <CommonCrypto/CommonDigest.h> //md5

@implementation AdBuddizPlugin

@synthesize callbackIdKeepCallback;
//
@synthesize email;
@synthesize licenseKey_;
@synthesize validLicenseKey;
static NSString *TEST_PUBLISHER_KEY = @"fdd256bc-1bc7-46a9-9bcb-46073eb668f6";
//
@synthesize publisherKey;
//
@synthesize interstitialAdPreload;

- (void) pluginInitialize {
    [super pluginInitialize];    
    //
}

- (void) setLicenseKey: (CDVInvokedUrlCommand*)command {
    NSString *email = [command.arguments objectAtIndex: 0];
    NSString *licenseKey = [command.arguments objectAtIndex: 1];
    NSLog(@"%@", email);
    NSLog(@"%@", licenseKey);
    
    [self.commandDelegate runInBackground:^{
        [self _setLicenseKey:email aLicenseKey:licenseKey];
    }];
}

- (void) setUp: (CDVInvokedUrlCommand*)command {
    //self.viewController
    //self.webView	
    //NSString *adUnitBanner = [command.arguments objectAtIndex: 0];
    //NSString *adUnitInterstitial = [command.arguments objectAtIndex: 1];
    //BOOL isOverlap = [[command.arguments objectAtIndex: 2] boolValue];
    //BOOL isTest = [[command.arguments objectAtIndex: 3] boolValue];
	//NSArray *zoneIds = [command.arguments objectAtIndex:4];	
    //NSLog(@"%@", adUnitBanner);
    //NSLog(@"%@", adUnitInterstitial);
    //NSLog(@"%d", isOverlap);
    //NSLog(@"%d", isTest);
	NSString* publisherKey = [command.arguments objectAtIndex:0];
	NSLog(@"%@", publisherKey);
	
    self.callbackIdKeepCallback = command.callbackId;
	
    [self.commandDelegate runInBackground:^{
		[self _setUp:publisherKey];	
    }];
}

- (void) preloadInterstitialAd: (CDVInvokedUrlCommand*)command {
    [self.commandDelegate runInBackground:^{
		[self _preloadInterstitialAd];
    }];
}

- (void) showInterstitialAd: (CDVInvokedUrlCommand*)command {
    [self.commandDelegate runInBackground:^{
		[self _showInterstitialAd];
    }];
}

- (void) preloadRewardedVideoAd: (CDVInvokedUrlCommand*)command {
/*
   [self.commandDelegate runInBackground:^{
		[self _preloadRewardedVideoAd];
    }];
*/	
}

- (void) showRewardedVideoAd: (CDVInvokedUrlCommand*)command {
/*
    //[self.commandDelegate runInBackground:^{
		[self _showRewardedVideoAd];
    //}];
*/	
}

- (void) _setLicenseKey:(NSString *)email aLicenseKey:(NSString *)licenseKey {
	self.email = email;
	self.licenseKey_ = licenseKey;
	
	//
	NSString *str1 = [self md5:[NSString stringWithFormat:@"cordova-plugin-: %@", email]];
	NSString *str2 = [self md5:[NSString stringWithFormat:@"cordova-plugin-ad-adbuddiz: %@", email]];
	NSString *str3 = [self md5:[NSString stringWithFormat:@"com.cranberrygame.cordova.plugin.: %@", email]];
	NSString *str4 = [self md5:[NSString stringWithFormat:@"com.cranberrygame.cordova.plugin.ad.adbuddiz: %@", email]];
	if(licenseKey_ != Nil && ([licenseKey_ isEqualToString:str1] || [licenseKey_ isEqualToString:str2] || [licenseKey_ isEqualToString:str3] || [licenseKey_ isEqualToString:str4])){
		self.validLicenseKey = YES;
		NSArray *excludedLicenseKeys = [NSArray arrayWithObjects: @"xxx", nil];
		for (int i = 0 ; i < [excludedLicenseKeys count] ; i++) {
			if([[excludedLicenseKeys objectAtIndex:i] isEqualToString:licenseKey]) {
				self.validLicenseKey = NO;
				break;
			}
		}
	}
	else {
		self.validLicenseKey = NO;
	}
	if (self.validLicenseKey)
		NSLog(@"valid licenseKey");
	else {
		NSLog(@"invalid licenseKey");
		//UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Cordova AdBuddiz: invalid email / license key. You can get free license key from https://play.google.com/store/apps/details?id=com.cranberrygame.pluginsforcordova" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[alert show];	
	}
}

- (NSString*) md5:(NSString*) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[16];
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

- (void) _setUp:(NSString *)publisherKey {
    self.publisherKey = publisherKey;
    
	if (!validLicenseKey) {
		if (arc4random() % 100 <= 1) {//0 ~ 99		
			self.publisherKey = TEST_PUBLISHER_KEY;
		}
	}
	
	//
	[AdBuddiz setPublisherKey:self.publisherKey];
    [AdBuddiz setDelegate:self];
}

-(void) _preloadInterstitialAd {
	self.interstitialAdPreload = YES;	
	
	[AdBuddiz cacheAds];
}

-(void) _showInterstitialAd {
	self.interstitialAdPreload = NO;	
	
    [AdBuddiz showAd];
}

-(void) _preloadRewardedVideoAd {
/*
	self.rewardedVideoAdPreload = YES;	
	
    [Chartboost cacheRewardedVideo:location];	
*/	
}

-(void) _showRewardedVideoAd {
/*
	self.rewardedVideoAdPreload = NO;	
	
	[Chartboost showRewardedVideo:location];
*/	
}

//AdBuddizDelegate

- (void) didCacheAd {
	NSLog(@"%@", @"didCacheAd");
	
	if(interstitialAdPreload) {
		CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onInterstitialAdPreloaded"];
		[pr setKeepCallbackAsBool:YES];
		[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
		//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
		//[pr setKeepCallbackAsBool:YES];
		//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];			
	}
	
	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onInterstitialAdLoaded"];
	[pr setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
	//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
	//[pr setKeepCallbackAsBool:YES];
	//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
}

- (void) didShowAd {
	NSLog(@"%@", @"didShowAd");
	
	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onInterstitialAdShown"];
	[pr setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
	//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
	//[pr setKeepCallbackAsBool:YES];
	//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];	
}

- (void) didFailToShowAd:(AdBuddizError) error {
	NSLog(@"%@", @"didFailToShowAd");
}

- (void) didClick {
	NSLog(@"%@", @"didClick");
}

- (void) didHideAd {
	NSLog(@"%@", @"didHideAd");
	
	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onInterstitialAdHidden"];
	[pr setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
	//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
	//[pr setKeepCallbackAsBool:YES];
	//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];	
}

/*
- (void) didCacheRewardedVideo:(CBLocation)location {
	NSLog(@"%@", @"didCacheRewardedVideo");

	if(moreAppsAdPreload) {
		NSDictionary* result = @{
			@"event":@"onRewardedVideoAdPreloaded",
			@"message":location
		};	
		//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onRewardedVideoAdPreloaded"];
		CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
		[pr setKeepCallbackAsBool:YES];
		[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
		//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
		//[pr setKeepCallbackAsBool:YES];
		//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];			
	}
	
	NSDictionary* result = @{
		@"event":@"onRewardedVideoAdLoaded",
		@"message":location
	};	
	//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onRewardedVideoAdLoaded"];
	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
	[pr setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
	//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
	//[pr setKeepCallbackAsBool:YES];
	//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
}

- (void) didFailToLoadRewardedVideo:(NSString *)location withError:(CBLoadError)error {
    switch(error){
        case CBLoadErrorInternetUnavailable: {
            NSLog(@"Failed to load Rewarded Video, no Internet connection !");
        } break;
        case CBLoadErrorInternal: {
            NSLog(@"Failed to load Rewarded Video, internal error !");
        } break;
        case CBLoadErrorNetworkFailure: {
            NSLog(@"Failed to load Rewarded Video, network error !");
        } break;
        case CBLoadErrorWrongOrientation: {
            NSLog(@"Failed to load Rewarded Video, wrong orientation !");
        } break;
        case CBLoadErrorTooManyConnections: {
            NSLog(@"Failed to load Rewarded Video, too many connections !");
        } break;
        case CBLoadErrorFirstSessionInterstitialsDisabled: {
            NSLog(@"Failed to load Rewarded Video, first session !");
        } break;
        case CBLoadErrorNoAdFound : {
            NSLog(@"Failed to load Rewarded Video, no ad found !");
        } break;
        case CBLoadErrorSessionNotStarted : {
            NSLog(@"Failed to load Rewarded Video, session not started !");
        } break;
        case CBLoadErrorNoLocationFound : {
            NSLog(@"Failed to load Rewarded Video, missing location parameter !");
        } break;
        default: {
            NSLog(@"Failed to load Rewarded Video, unknown error !");
        }
    }
}

- (BOOL) shouldDisplayRewardedVideo:(CBLocation)location {
    return YES;
}

- (void) didDisplayRewardedVideo:(CBLocation)location {
	NSLog(@"%@", @"didDisplayRewardedVideo");
	
	NSDictionary* result = @{
		@"event":@"onRewardedVideoAdShown",
		@"message":location
	};	
	//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onRewardedVideoAdShown"];
	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
	[pr setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
	//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
	//[pr setKeepCallbackAsBool:YES];
	//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
}

- (void) didClickRewardedVideo:(CBLocation)location {
	NSLog(@"%@", @"didClickRewardedVideo");
}

- (void) didCloseRewardedVideo:(CBLocation)location {
	NSLog(@"%@", @"didCloseRewardedVideo");
}

- (void) didDismissRewardedVideo:(CBLocation)location {
	NSLog(@"%@", @"didDismissRewardedVideo");
	
	NSDictionary* result = @{
		@"event":@"onRewardedVideoAdHidden",
		@"message":location
	};	
	//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onRewardedVideoAdHidden"];
	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
	[pr setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
	//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
	//[pr setKeepCallbackAsBool:YES];
	//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
}

- (void) didCompleteRewardedVideo:(CBLocation)location withReward:(int)reward {
    //NSLog(@"completed rewarded video view at location %@ with reward amount %d", location, reward);
	NSLog(@"%@", @"didCompleteRewardedVideo");
	
	NSDictionary* result = @{
		@"event":@"onRewardedVideoAdCompleted",
		@"message":location
	};	
	//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onRewardedVideoAdCompleted"];
	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsDictionary:result];
	[pr setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
	//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
	//[pr setKeepCallbackAsBool:YES];
	//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
}
*/

@end
