//
//  ProjectProfileViewController.h
//  UserStories
//
//  Created by ANUJ DESHMUKH on 10/17/14.
//  Copyright (c) 2014 DESHMUKH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBookUI/AddressBookUI.h>

@interface ProjectProfileViewController : UIViewController {
    __weak IBOutlet UITextView *txtViewDescription;
    __weak IBOutlet UITextField *txtFldDesignation;
    __weak IBOutlet UITextField *txtFldProjectName;
IBOutlet UITableView *tblViewProjects;
    
NSMutableArray *arrProjects;
    NSMutableArray *arrStakeHolders;
}
- (IBAction)SaveProjectProfile:(id)sender;
- (void)listPeopleInAddressBook:(ABAddressBookRef)addressBook;
@end
