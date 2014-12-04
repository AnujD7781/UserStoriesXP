//
//  UserStoriesModel.h
//  UserStoriesXP
//
//  Created by ANUJ DESHMUKH on 11/20/14.
//  Copyright (c) 2014 DESHMUKH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserStoriesModel : NSObject
@property (nonatomic,retain) NSString * strProjectTitle;
@property (nonatomic,retain) NSString * strDesignation;
@property (nonatomic,retain) NSString * strUserStory;
@property (nonatomic,retain) NSString * strCost;
@property (nonatomic,retain) NSString * strPriority;

+(UserStoriesModel*) initWithTitle:(NSString*)strTitle designation:(NSString*)strDesignation priority:(NSString*)strPriority  cost:(NSString*)strCost userStory:(NSString*)strUserStory;
@end
