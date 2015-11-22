//
//  SaltSideNetworkManager.h
//  SaltsideDemo
//
//  Created by Ajay Agarwal on 11/22/15.
//  Copyright © 2015 Ajay Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaltSideNetworkManager : NSObject <NSURLSessionDelegate>
-(void)sendRequestWithURL:(NSURL *)url completion:(void(^)(NSData *data, NSURLResponse *response, NSError *error))callback;
@end
