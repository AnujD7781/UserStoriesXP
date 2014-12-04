//
//  ProjectProfileModel.h
//  UserStoriesXP
//
//  Created by ANUJ DESHMUKH on 11/20/14.
//  Copyright (c) 2014 DESHMUKH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectProfileModel : NSObject 
@property (nonatomic,retain) NSString * strProjectTitle;
@property (nonatomic,retain) NSString * strDesignation;
@property (nonatomic,retain) NSString * strDescription;
@property (nonatomic,retain) NSArray * arrStakeHolders;


+(ProjectProfileModel*) initWithTitle:(NSString*)strTitle designation:(NSString*)strDesignation description:(NSString*)strDesc stakeHolders:(NSArray*)arrStakeHolders;
@end
