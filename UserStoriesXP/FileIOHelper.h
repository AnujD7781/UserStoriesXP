//
//  FileIOHelper.h
//  UserStoriesXP
//
//  Created by ANUJ DESHMUKH on 11/26/14.
//  Copyright (c) 2014 DESHMUKH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileIOHelper : NSObject
+(BOOL) writeToTextFile : (NSDictionary*)jsonDictionary;
+(NSString*) getJsonData;
@end
