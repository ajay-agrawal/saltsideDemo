//
//  SaltSideParser.h
//  SaltsideDemo
//
//  Created by Ajay Agarwal on 11/22/15.
//  Copyright © 2015 Ajay Agarwal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SaltSideParser : NSObject


-(NSMutableDictionary *)parseJSONData:(NSData *)aData withError:(NSError **)aError;


@end
