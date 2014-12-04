//
//  Base64Helper.h
//  UserStoriesXP
//
//  Created by ANUJ DESHMUKH on 12/1/14.
//  Copyright (c) 2014 DESHMUKH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (EncodingDevoding)

- (NSString*) encodedStringForString;
- (NSString*) decodedStringForString;
@end
