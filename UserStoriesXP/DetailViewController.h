//
//  DetailViewController.h
//  UserStoriesXP
//
//  Created by ANUJ DESHMUKH on 11/18/14.
//  Copyright (c) 2014 DESHMUKH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIPlaceHolderTextView.h"
#import "ProjectProfileModel.h"
#import "UserStoriesModel.h"
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
@interface DetailViewController : UIViewController<MFMailComposeViewControllerDelegate> {
    MFMailComposeViewController *mailComposer;

}
@property (weak, nonatomic) IBOutlet UITextField *txtFldDesignation;
@property (weak, nonatomic) IBOutlet UIPlaceHolderTextView *txtViewUserStory;
@property (weak, nonatomic) IBOutlet UISegmentedControl *chkBoxPriority;
@property (weak, nonatomic) IBOutlet UITextField *txtFldCost;

@property (strong, nonatomic) ProjectProfileModel *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

