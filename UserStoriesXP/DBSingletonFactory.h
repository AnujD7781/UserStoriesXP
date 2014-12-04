//
//  DBSingletonFactory.h
//  UserStoriesXP
//
//  Created by ANUJ DESHMUKH on 11/20/14.
//  Copyright (c) 2014 DESHMUKH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "UserStoriesModel.h"
#import "ProjectProfileModel.h"
@interface DBSingletonFactory : NSObject {
    NSString *databasePath;
}
+(DBSingletonFactory*)getSharedInstance;
-(BOOL)createDB;
-(NSArray*)getAllProjectProfiles;
-(NSArray*)getAllUserStories;
-(BOOL)saveUserStory:(UserStoriesModel*)userStory;
-(BOOL)saveProjectProfile:(ProjectProfileModel*)projectProfile;
-(NSArray*)getAllUserStoriesForProjectName:(NSString*)projectTitle;
@end
