//
//  UserStoriesModel.m
//  UserStoriesXP
//
//  Created by ANUJ DESHMUKH on 11/20/14.
//  Copyright (c) 2014 DESHMUKH. All rights reserved.
//

#import "UserStoriesModel.h"

@implementation UserStoriesModel
@synthesize strCost, strDesignation,strPriority,strProjectTitle, strUserStory;
+(UserStoriesModel*) initWithTitle:(NSString*)strTitle designation:(NSString*)strDesignation priority:(NSString*)strPriority  cost:(NSString*)strCost userStory:(NSString*)strUserStory{
    UserStoriesModel *userStory = [[UserStoriesModel alloc]init];
    userStory.strProjectTitle = strTitle;
    userStory.strPriority = strPriority;
    userStory.strDesignation = strDesignation;
    userStory.strCost = strCost;
    userStory.strUserStory = strUserStory;
    
    return userStory;
}
@end
