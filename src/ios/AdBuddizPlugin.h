#import <Foundation/Foundation.h>
#import <Cordova/CDV.h>

@interface AdBuddizPlugin : CDVPlugin

- (void)init: (CDVInvokedUrlCommand*)command;
- (void)showFullScreenAd: (CDVInvokedUrlCommand*)command;

@end
