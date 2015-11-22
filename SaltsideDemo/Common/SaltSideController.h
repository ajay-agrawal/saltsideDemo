//
//  SaltSideController.h
//  SaltsideDemo
//
//  Created by Ajay Agarwal on 11/22/15.
//  Copyright © 2015 Ajay Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaltSideController : NSObject{


}


+ (SaltSideController*)sharedInstance;
-(id)parseJSONData:(NSData *)aData withError:(NSError **)aError;
-(void)sendRequestWithURL:(NSString *)urlString completion:(void(^)(NSData *data, NSURLResponse *response, NSError *error))callback;
-(BOOL)isHostAvailable;

@end
