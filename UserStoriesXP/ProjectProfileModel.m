//
//  ProjectProfileModel.m
//  UserStoriesXP
//
//  Created by ANUJ DESHMUKH on 11/20/14.
//  Copyright (c) 2014 DESHMUKH. All rights reserved.
//

#import "ProjectProfileModel.h"

@implementation ProjectProfileModel
@synthesize strProjectTitle, strDesignation, strDescription, arrStakeHolders;
+(ProjectProfileModel*) initWithTitle:(NSString*)strTitle designation:(NSString*)strDesignation description:(NSString*)strDesc stakeHolders:(NSArray*)arrStakeHolders {
    ProjectProfileModel *projectProfile = [[ProjectProfileModel alloc]init];
    projectProfile.strDesignation = strDesignation;
    projectProfile.strDescription = strDesc;
    projectProfile.strProjectTitle = strTitle;
    projectProfile.arrStakeHolders = [NSArray arrayWithArray:arrStakeHolders];
    NSLog(@"%@",projectProfile.strProjectTitle);
    return projectProfile;
}
@end
