//
//  SaltSideParser.m
//  SaltsideDemo
//
//  Created by Ajay Agarwal on 11/22/15.
//  Copyright © 2015 Ajay Agarwal. All rights reserved.
//

#import "SaltSideParser.h"

@implementation SaltSideParser

-(NSMutableDictionary *)parseJSONData:(NSData *)responseData withError:(NSError **)aError{
    NSError *jsonError;
    NSMutableDictionary *responseJSON = [NSJSONSerialization
                                         JSONObjectWithData:responseData
                                         options:NSJSONReadingAllowFragments
                                         error:&jsonError];
    
    if (!jsonError) {
        return responseJSON;
    }else{
        // handle bad json format
        return nil;
    }
    
    //return [NSJSONSerialization JSONObjectWithData: aData options: NSJSONReadingAllowFragments error: aError];
}

@end
