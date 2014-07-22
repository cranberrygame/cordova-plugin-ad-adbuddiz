#import "AdBuddizPlugin.h"
//
#import <AdBuddiz/AdBuddiz.h>

@implementation AdBuddizPlugin

@synthesize preloaded;

- (void)preloadFullScreenAd: (CDVInvokedUrlCommand*)command {
	NSString *publisherKey = [command.arguments objectAtIndex: 0];
	NSLog(@"%@", publisherKey);

	[self _preloadFullScreenAd:publisherKey];
    
	[self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
	//[self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
}

- (void)showFullScreenAd: (CDVInvokedUrlCommand*)command {
	NSString *publisherKey = [command.arguments objectAtIndex: 0];
	NSLog(@"%@", publisherKey);

	[self _showFullScreenAd:publisherKey];

	[self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_OK] callbackId:command.callbackId];
	//[self.commandDelegate sendPluginResult:[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR] callbackId:command.callbackId];
}

//-------------------------------------------------------------------

- (void) _preloadFullScreenAd:(NSString *)publisherKey
{
	if (!preloaded)
	{
		[AdBuddiz setPublisherKey:publisherKey];
		[AdBuddiz cacheAds];
		
		preloaded = YES;
	}
}
- (void) _showFullScreenAd:(NSString *)publisherKey
{
	if (!preloaded)
	{
		_preloadFullScreenAd:publisherKey;
	}
	
    [self.commandDelegate runInBackground:^{
        [AdBuddiz showAd];
    }];
}

@end
