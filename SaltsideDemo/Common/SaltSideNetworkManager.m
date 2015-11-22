//
//  SaltSideNetworkManager.m
//  SaltsideDemo
//
//  Created by Ajay Agarwal on 11/22/15.
//  Copyright © 2015 Ajay Agarwal. All rights reserved.
//

#import "SaltSideNetworkManager.h"
#import "Reachability.h"
@interface SaltSideNetworkManager()

@property(atomic, strong) NSURLSession *session;

@end

@implementation SaltSideNetworkManager


-(id)init{
    self = [super init];
    if (self) {
        if (_session == nil) {
            _session = [NSURLSession sessionWithConfiguration:[self getDefaultNetworkConfiguration]
                                                     delegate:self
                                                delegateQueue:nil];
        }
        
    }
    return self;
}

-(BOOL)isNetworkAvailable{
    @synchronized(self) {
        // Create zero addy
        struct sockaddr_in zeroAddress;
        bzero(&zeroAddress, sizeof(zeroAddress));
        zeroAddress.sin_len = sizeof(zeroAddress);
        zeroAddress.sin_family = AF_INET;
        
        // Recover reachability flags
        SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
        SCNetworkReachabilityFlags flags;
        
        BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
        CFRelease(defaultRouteReachability);
        
        if (!didRetrieveFlags)
        {
            //NSLog(@"Error. Could not recover network reachability flags");
            return NO;
        }
        
        BOOL isReachable = flags & kSCNetworkFlagsReachable;
        BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
        BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
        
        return ((isReachable && !needsConnection) || nonWiFi);
    }
}

-(NSURLSessionConfiguration *)getDefaultNetworkConfiguration{
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    sessionConfig.timeoutIntervalForRequest = 30.0;
    sessionConfig.timeoutIntervalForResource = 60.0;
    sessionConfig.HTTPMaximumConnectionsPerHost = 4;
//    NSString *authStr = @"SomeHTTPAuthString";
//    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *authValue = [NSString stringWithFormat: @"Basic %@",[authData base64EncodedStringWithOptions:0]];
//    [sessionConfig setHTTPAdditionalHeaders:@{@"Authorization":authValue}];
    return sessionConfig;
}

-(void)sendRequestWithURL:(NSURL *)url completion:(void(^)(NSData *data, NSURLResponse *response, NSError *error))callback{
    [[_session dataTaskWithURL:url
             completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                 if (!error) {
                     NSHTTPURLResponse *httpResp = (NSHTTPURLResponse*) response;
                     if (httpResp.statusCode == 200) {
                         callback(data, response, error);
                     } else {
                         // HANDLE BAD RESPONSE //
                     }
                 } else {
                     // ALWAYS HANDLE ERRORS :-] //
                 }
             }] resume];
    
}

@end
