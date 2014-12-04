//
//  Base64Helper.m
//  UserStoriesXP
//
//  Created by ANUJ DESHMUKH on 12/1/14.
//  Copyright (c) 2014 DESHMUKH. All rights reserved.
//

#import "Base64Helper.h"

@implementation NSString (EncodingDevoding)
- (NSString*) encodedStringForString {
    NSData *plainData = [self  dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [plainData base64EncodedStringWithOptions:0];
    return base64String;
}
- (NSString*) decodedStringForString {
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    return decodedString;
}
@end
