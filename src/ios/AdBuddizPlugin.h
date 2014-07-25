// cranberrygame@yahoo.com
// http://www.github.com/cranberrygame
// MIT Licensed
#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface AdBuddizPlugin : CDVPlugin

@property BOOL preloaded;

- (void)preloadFullScreenAd: (CDVInvokedUrlCommand*)command;
- (void)showFullScreenAd: (CDVInvokedUrlCommand*)command;

@end
