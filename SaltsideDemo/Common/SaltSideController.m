//
//  SaltSideController.m
//  SaltsideDemo
//
//  Created by Ajay Agarwal on 11/22/15.
//  Copyright © 2015 Ajay Agarwal. All rights reserved.
//

#import "SaltSideController.h"
#import "SaltSideNetworkManager.h"
#import "SaltSideParser.h"
#import "Reachability.h"

#define APP_SERVER_HOST @"gist.githubusercontent.com"

@interface SaltSideController () {
    SaltSideParser *responseParser;
    SaltSideNetworkManager *networkManager;
}
@end

@implementation SaltSideController

- (id)init
{
    self = [super init];
    if (self) {
        responseParser = [[SaltSideParser alloc] init];
        networkManager = [[SaltSideNetworkManager alloc] init];
    }
    return self;
}

-(id)parseJSONData:(NSData *)aData withError:(NSError **)aError{
    return [responseParser parseJSONData:aData withError:aError];
}

-(void)sendRequestWithURL:(NSString *)urlString completion:(void(^)(NSData *data, NSURLResponse *response, NSError *error))callback{
    [networkManager sendRequestWithURL:[NSURL URLWithString:urlString] completion:^(NSData *data, NSURLResponse *response, NSError *error) {
        callback(data, response, error);
    }];
}

-(BOOL)isHostAvailable{
    Reachability *netReach = [Reachability reachabilityWithHostName:APP_SERVER_HOST];
    //return [netReach currentReachabilityStatus];
    NetworkStatus netStatus = [netReach currentReachabilityStatus];
    if (netStatus==ReachableViaWiFi || netStatus==ReachableViaWWAN) {
        return YES;
    }
    return NO;
}

+ (SaltSideController *)sharedInstance
{
    static SaltSideController *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[SaltSideController alloc] init];
    });
    return _sharedInstance;
}


@end
