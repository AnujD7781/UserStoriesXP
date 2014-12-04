//
//  FileIOHelper.m
//  UserStoriesXP
//
//  Created by ANUJ DESHMUKH on 11/26/14.
//  Copyright (c) 2014 DESHMUKH. All rights reserved.
//

#import "FileIOHelper.h"
#import "JSONHelper.h"
#import "Base64Helper.h"
@implementation FileIOHelper
//Method writes a string to a text file
+(BOOL) writeToTextFile : (NSDictionary*)jsonDictionary {
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/jsonData.txt",
                          documentsDirectory];
    //create content - four lines of text
    NSString *content = [jsonDictionary bv_jsonStringWithPrettyPrint:YES ];
    NSLog(@
          "%@",content);
    //save content to the documents directory
   
    [[content encodedStringForString] writeToFile:fileName
              atomically:NO
                encoding:NSStringEncodingConversionAllowLossy
                   error:nil];
    
    return NO;
    
}


//Method retrieves content from documents directory and
//displays it in an alert
+(NSString*) getJsonData{
    //get the documents directory:
    NSArray *paths = NSSearchPathForDirectoriesInDomains
    (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    //make a file name to write the data to using the documents directory:
    NSString *fileName = [NSString stringWithFormat:@"%@/jsonData.txt",
                          documentsDirectory];
    NSString *content = [[NSString alloc] initWithContentsOfFile:fileName
                                                    usedEncoding:nil
                                                           error:nil];
    
    
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:[content decodedStringForString] options:0];
    NSString *decodedString = [[NSString alloc] initWithData:decodedData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", decodedString);
    
    //use simple alert from my library (see previous post for details)
    return [content decodedStringForString];
}
@end
