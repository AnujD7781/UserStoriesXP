//
//  UserStoriesViewController.m
//  UserStories
//
//  Created by ANUJ DESHMUKH on 10/20/14.
//  Copyright (c) 2014 DESHMUKH. All rights reserved.
//

#import "UserStoriesViewController.h"
#import "UserStoriesModel.h"
#import "Flurry.h"

@interface UserStoriesViewController ()

@end
static MFMailComposeViewController  *_mailComposerVC;
@implementation UserStoriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];

    _mailComposerVC = [[MFMailComposeViewController alloc] init];
    _mailComposerVC.mailComposeDelegate = self;
    [Flurry logEvent:@"UserStoryFinalPage"];
    
}
-(void)viewDidAppear:(BOOL)animated {
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationLandscapeLeft];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
    barBtnItemTitle.title = userStoryGBL.strProjectTitle;
    lblCost.text = userStoryGBL.strCost;
    txtViewUserStory.text = userStoryGBL.strUserStory;
    lblDesignation.text = userStoryGBL.strDesignation;
    lblPriority.text = userStoryGBL.strPriority;
}
-(void)viewDidDisappear:(BOOL)animated {
    NSNumber *value = [NSNumber numberWithInt:UIInterfaceOrientationPortrait];
    [[UIDevice currentDevice] setValue:value forKey:@"orientation"];
}
-(void)configuerView:(UserStoriesModel*)userStory {
    userStoryGBL  = userStory;
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)sendMail:(id)sender{
    mailComposer = [[MFMailComposeViewController alloc]init];
    mailComposer.mailComposeDelegate = self;
    [mailComposer setSubject:@"Test mail"];
    [mailComposer setMessageBody:@"Your user story is" isHTML:NO];
    // [self presentModalViewController:mailComposer animated:YES];
    [self presentViewController:mailComposer animated:YES completion:nil];
     }
     
#pragma mark - mail compose delegate
    -(void)mailComposeController:(MFMailComposeViewController *)controller
             didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
                 if (result) {
                     NSLog(@"Result : %d",result);
                 }
                 if (error) {
                     NSLog(@"Error : %@",error);
                 }
                 [self dismissViewControllerAnimated:YES completion:nil];
                 
             }
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnActionEmail:(id)sender {
       if(![MFMailComposeViewController canSendMail] ) {
            NSLog(@"Cannot send mail\n%s", __PRETTY_FUNCTION__) ;
            return ;
        }
        
    
        
    
    NSMutableString *htmlMsg = [NSMutableString string];
    [htmlMsg appendString:@"<html><body><p>"];
    [htmlMsg appendString:@"Please find attached user story for "];
    [htmlMsg appendString:@": %@</p></body></html>"];
    
    NSData *jpegData = UIImagePNGRepresentation([UIImage imageNamed:@"Background.png"]);
    
    NSString *fileName = @"test";
    fileName = [fileName stringByAppendingPathExtension:@"png"];
    [_mailComposerVC addAttachmentData:jpegData mimeType:@"image/png" fileName:fileName];
    
    
    [_mailComposerVC setSubject:@"email subject"];
    [_mailComposerVC setMessageBody:htmlMsg isHTML:YES];
    
        // Present mail view controller on screen
        [self presentViewController:_mailComposerVC animated:YES completion:NULL];
    NSLog(@"I am under email section");
    
}
@end
