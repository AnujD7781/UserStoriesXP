//
//  DBSingletonFactory.m
//  UserStoriesXP
//
//  Created by ANUJ DESHMUKH on 11/20/14.
//  Copyright (c) 2014 DESHMUKH. All rights reserved.
//

#import "DBSingletonFactory.h"
#import "UserStoriesModel.h"
#import "ProjectProfileModel.h"
static DBSingletonFactory *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBSingletonFactory

+(DBSingletonFactory*)getSharedInstance {
    if (!sharedInstance) {
        sharedInstance = [[super allocWithZone:NULL]init];
        [sharedInstance createDB];
    }
    return sharedInstance;

}
-(BOOL)createDB {
    
    databasePath = [[NSBundle mainBundle]pathForResource:@"UserStories" ofType:@"sqlite3"];
    if (sqlite3_open([databasePath UTF8String], &database) != SQLITE_OK) {
        NSLog(@"Failed to open database!");
        return NO;
    }else {
        NSLog(@"DB opened properly");
    }
    
    return NO;
}
-(NSArray *)getAllUserStories {
    NSMutableArray *arrUserStories = [[NSMutableArray alloc]init];
    
    return arrUserStories;
}
-(NSArray*)getAllProjectProfiles {
    NSMutableArray *arrProjectProfiles = [[NSMutableArray alloc]init];
    
    NSString *query = @"SELECT Title, Designation, Description from ProjectProfile";
    sqlite3_stmt *statement;
    
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) != SQLITE_OK)
        {
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
        } else {
            // do things with addStmt, call sqlite3_step
            NSLog(@"its under it");
            while (sqlite3_step(statement) == SQLITE_ROW) {
                //int uniqueId = sqlite3_column_int(statement, 0);
                char *projectTitle = (char *) sqlite3_column_text(statement, 0);
                char *Designation = (char *) sqlite3_column_text(statement, 1);
                char *Description = (char *) sqlite3_column_text(statement, 2);
                NSString *title = [[NSString alloc] initWithUTF8String:projectTitle];
                NSString *designation = [[NSString alloc] initWithUTF8String:Designation];
                NSString *description = [[NSString alloc] initWithUTF8String:Description];
                ProjectProfileModel *projectProfile = [ProjectProfileModel initWithTitle:title designation:designation description:description stakeHolders:nil];
                [arrProjectProfiles addObject:projectProfile];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(database);
    }
    
    return arrProjectProfiles;
}

-(NSArray*)getStakeHoldersForProject:(NSString*)title {
    NSMutableArray *arrProjectProfiles = [[NSMutableArray alloc]init];
    
    NSString *query = [NSString stringWithFormat:@"" @"SELECT StakeHolder from StakeHolder where ProjectTitle = '%@'",title];
    sqlite3_stmt *statement;
    
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) != SQLITE_OK)
        {
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
        } else {
            // do things with addStmt, call sqlite3_step
            NSLog(@"its under it");
            while (sqlite3_step(statement) == SQLITE_ROW) {
                //int uniqueId = sqlite3_column_int(statement, 0);
                char *stakeHolder = (char *) sqlite3_column_text(statement, 0);
                NSString *stakeHolderStr = [[NSString alloc] initWithUTF8String:stakeHolder];
                [arrProjectProfiles addObject:stakeHolderStr];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(database);
    }
    
    return arrProjectProfiles;
}

-(NSArray*)getAllUserStoriesForProjectName:(NSString*)projectTitle {
    NSMutableArray *arrUserStories = [[NSMutableArray alloc]init];
    NSString *query = [NSString stringWithFormat:@"" @"SELECT Title, Designation, UserStory, Priority, Cost from UserStories where Title = '%@'",projectTitle];
    sqlite3_stmt *statement;
    
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) != SQLITE_OK)
        {
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
        } else {
            // do things with addStmt, call sqlite3_step
            NSLog(@"its under it");
            while (sqlite3_step(statement) == SQLITE_ROW) {
                //int uniqueId = sqlite3_column_int(statement, 0);
                char *title = (char *) sqlite3_column_text(statement, 0);
                char *designation = (char *) sqlite3_column_text(statement, 1);
                char *userStory = (char *) sqlite3_column_text(statement, 2);
                char *priority = (char *) sqlite3_column_text(statement, 3);
                char *Cost = (char *) sqlite3_column_text(statement, 4);
                NSString *strTitle = [[NSString alloc] initWithUTF8String:title];
                NSString *strUserStory = [[NSString alloc] initWithUTF8String:userStory];
                NSString *strPriority = [[NSString alloc] initWithUTF8String:priority];
                NSString *strCost = [[NSString alloc] initWithUTF8String:Cost];
                
                NSString *strDesignation = [[NSString alloc]initWithUTF8String:designation];
                                           
                UserStoriesModel *userStoryModel = [UserStoriesModel initWithTitle:strTitle designation:strDesignation priority:strPriority cost:strCost userStory:strUserStory];
               [arrUserStories addObject:userStoryModel];
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(database);
    }
    

    return arrUserStories;
}
-(BOOL)saveUserStory:(UserStoriesModel*)userStory  {
    NSString *strSql;
    strSql = @"INSERT INTO UserStories (Title, Designation, UserStory, Priority, Cost) VALUES(?,?,?,?,?)";
    
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [strSql UTF8String], -1, &statement, NULL) != SQLITE_OK)
        {
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
        } else {
            sqlite3_bind_text(statement, 1, [userStory.strUserStory UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 2, [userStory.strDesignation UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 3, [userStory.strUserStory UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 4, [userStory.strPriority UTF8String], -1, SQLITE_TRANSIENT);
            sqlite3_bind_text(statement, 5, [userStory.strCost UTF8String], -1, SQLITE_TRANSIENT);
            
            if (sqlite3_step(statement) == SQLITE_DONE) {
                sqlite3_finalize(statement);
            }
        }
    }
    return NO;
}

-(BOOL)saveProjectProfile:(ProjectProfileModel*)projectProfile {
    NSString *strSql;
    strSql = @"INSERT INTO ProjectProfile (Title, Designation, Description) VALUES(?,?,?)";
    
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK)
    {
        if(sqlite3_prepare_v2(database, [strSql UTF8String], -1, &statement, NULL) != SQLITE_OK)
        {
            NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
        } else {
               sqlite3_bind_text(statement, 1, [projectProfile.strProjectTitle UTF8String], -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(statement, 2, [projectProfile.strDesignation UTF8String], -1, SQLITE_TRANSIENT);
                sqlite3_bind_text(statement, 3, [projectProfile.strDescription UTF8String], -1, SQLITE_TRANSIENT);
                    if (sqlite3_step(statement) == SQLITE_DONE) {
                        sqlite3_finalize(statement);
                        }
            }
    }
    
   // BOOL isStatus = [self save]
    
    

    return NO;
}
@end
