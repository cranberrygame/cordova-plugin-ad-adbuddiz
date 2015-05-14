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
@synthesize fullScreenAdPreload;

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
	//NSString *adUnit = [command.arguments objectAtIndex: 0];
	//NSString *adUnitFullScreen = [command.arguments objectAtIndex: 1];
	//BOOL isOverlap = [[command.arguments objectAtIndex: 2] boolValue];
	//BOOL isTest = [[command.arguments objectAtIndex: 3] boolValue];
	//NSLog(@"%@", adUnit);
	//NSLog(@"%@", adUnitFullScreen);
	//NSLog(@"%d", isOverlap);
	//NSLog(@"%d", isTest);
	NSString* publisherKey = [command.arguments objectAtIndex:0];
	NSLog(@"%@", publisherKey);
	
    self.callbackIdKeepCallback = command.callbackId;
	
    [self.commandDelegate runInBackground:^{
		[self _setUp:publisherKey];	
    }];
}

- (void) preloadFullScreenAd: (CDVInvokedUrlCommand*)command {
    [self.commandDelegate runInBackground:^{
		[self _preloadFullScreenAd];
    }];
}

- (void) showFullScreenAd: (CDVInvokedUrlCommand*)command {
    [self.commandDelegate runInBackground:^{
		[self _showFullScreenAd];
    }];
}

- (void) _setLicenseKey:(NSString *)email aLicenseKey:(NSString *)licenseKey {
	self.email = email;
	self.licenseKey_ = licenseKey;
	
	//
	NSString *str1 = [self md5:[NSString stringWithFormat:@"com.cranberrygame.cordova.plugin.: %@", email]];
	NSString *str2 = [self md5:[NSString stringWithFormat:@"com.cranberrygame.cordova.plugin.ad.chartboost: %@", email]];
	if(licenseKey_ != Nil && ([licenseKey_ isEqualToString:str1] || [licenseKey_ isEqualToString:str2])){
		NSLog(@"valid licenseKey");
		validLicenseKey = YES;		
	}
	else {
		NSLog(@"invalid licenseKey");
		validLicenseKey = NO;
		
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

-(void) _preloadFullScreenAd {
	self.fullScreenAdPreload = YES;	
	
	[AdBuddiz cacheAds];
}

-(void) _showFullScreenAd {
	self.fullScreenAdPreload = NO;	
	
    [AdBuddiz showAd];
}

//AdBuddizDelegate

- (void) didCacheAd {
	NSLog(@"%@", @"didCacheAd");
	
/*
	if(fullScreenAdPreload) {
		CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onFullScreenAdPreloaded"];
		[pr setKeepCallbackAsBool:YES];
		[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
		//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
		//[pr setKeepCallbackAsBool:YES];
		//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];			
	}
	
	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onFullScreenAdLoaded"];
	[pr setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
	//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
	//[pr setKeepCallbackAsBool:YES];
	//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
*/	
}

- (void) didShowAd {
	NSLog(@"%@", @"didShowAd");
	
	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onFullScreenAdShown"];
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
	
	CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"onFullScreenAdHidden"];
	[pr setKeepCallbackAsBool:YES];
	[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];
	//CDVPluginResult* pr = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
	//[pr setKeepCallbackAsBool:YES];
	//[self.commandDelegate sendPluginResult:pr callbackId:callbackIdKeepCallback];	
}

@end
