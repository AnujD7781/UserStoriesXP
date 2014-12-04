//
//  JSONHelper.h
//  UserStoriesXP
//
//  Created by ANUJ DESHMUKH on 11/26/14.
//  Copyright (c) 2014 DESHMUKH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserStoriesModel.h"
@interface NSDictionary (BVJSONString)
-(NSString*) bv_jsonStringWithPrettyPrint:(BOOL) prettyPrint;
+(NSDictionary*)getDictionaryForUserStory:(UserStoriesModel*)userStory;
@end
