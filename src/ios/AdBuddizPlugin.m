#import "AdBuddizPlugin.h"
#import <AdBuddiz/AdBuddiz.h>

@implementation AdBuddizPlugin

- (void)init: (CDVInvokedUrlCommand*)command {
	NSArray* arguments = command.arguments;
	
    [AdBuddiz setPublisherKey: [arguments objectAtIndex: 0]];
    [AdBuddiz cacheAds];
}

- (void)showFullScreenAd: (CDVInvokedUrlCommand*)command {    
    [self.commandDelegate runInBackground:^{
        [AdBuddiz showAd];
    }];
}

@end
