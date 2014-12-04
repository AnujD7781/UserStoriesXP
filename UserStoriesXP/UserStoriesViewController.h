//
//  UserStoriesViewController.h
//  UserStories
//
//  Created by ANUJ DESHMUKH on 10/20/14.
//  Copyright (c) 2014 DESHMUKH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "UserStoriesModel.h"

@interface UserStoriesViewController : UIViewController<MFMailComposeViewControllerDelegate> {
    
    __weak IBOutlet UIBarButtonItem *barBtnItemTitle;
    __weak IBOutlet UITextView *txtViewUserStory;
    __weak IBOutlet UILabel *lblDesignation;
    
    __weak IBOutlet UILabel *lblCost;
    __weak IBOutlet UILabel *lblPriority;
    MFMailComposeViewController *mailComposer;
    UserStoriesModel *userStoryGBL;
    __strong MFMailComposeViewController *mc;
}
- (IBAction)btnActionEmail:(id)sender;
-(void)configuerView:(UserStoriesModel*)userStory;
@end
