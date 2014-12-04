//
//  JSONHelper.m
//  UserStoriesXP
//
//  Created by ANUJ DESHMUKH on 11/26/14.
//  Copyright (c) 2014 DESHMUKH. All rights reserved.
//

#import "JSONHelper.h"
@implementation NSDictionary (BVJSONString)
-(NSString*) bv_jsonStringWithPrettyPrint:(BOOL) prettyPrint {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:(NSJSONWritingOptions)    (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    
    if (! jsonData) {
        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        return @"{}";
    } else {
        return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
}

+(NSDictionary*)getDictionaryForUserStory:(UserStoriesModel*)userStory {
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:userStory.strCost forKey:@"COST"];
    [dict setObject:userStory.strDesignation forKey:@"DESIGNATION"];
    [dict setObject:userStory.strPriority forKey:@"PRIORITY"];
    [dict setObject:userStory.strProjectTitle forKey:@"TITLE"];
    [dict setObject:userStory.strUserStory forKey:@"USERSTORY"];
    
    return dict;
}
@end
