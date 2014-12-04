//
//  DetailViewController.m
//  UserStoriesXP
//
//  Created by ANUJ DESHMUKH on 11/18/14.
//  Copyright (c) 2014 DESHMUKH. All rights reserved.
//

#import "DetailViewController.h"
#import "DBSingletonFactory.h"
#import "UserStoriesViewController.h"
#import "JSONHelper.h"
#import "FileIOHelper.h"
#import "Flurry.h"


@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
 
    if (_detailItem != newDetailItem) {
        _detailItem = (ProjectProfileModel*) newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    
    // Update the user interface for the detail item.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    if (self.detailItem) {
        self.title = _detailItem.strProjectTitle;
        NSMutableArray *arrM = [[NSMutableArray alloc]init];
        [arrM addObjectsFromArray:[[DBSingletonFactory getSharedInstance]getAllUserStoriesForProjectName:_detailItem.strProjectTitle]];
        NSLog(@"%@", arrM);
        self.txtFldDesignation.text = _detailItem.strDesignation;
        UIBarButtonItem *flipButton = [[UIBarButtonItem alloc]
                                       initWithTitle:@"Save"
                                       style:UIBarButtonItemStyleDone target:self action:@selector(saveData:)];
       
     
        self.navigationItem.rightBarButtonItem = flipButton;
        self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
        
        
    }
    
}
-(void)sendMail:(id)sender{
    if(![MFMailComposeViewController canSendMail] ) {
        NSLog(@"Cannot send mail\n%s", __PRETTY_FUNCTION__) ;
        return ;
    }
    
    // Email Subject
   
    
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    NSMutableString *htmlMsg = [NSMutableString string];
    [htmlMsg appendString:@"<html><body><p>"];
    [htmlMsg appendString:@"Please find attached user story for "];
    [htmlMsg appendString:@": %@</p></body></html>"];
    
    NSData *jpegData = UIImageJPEGRepresentation([UIImage imageNamed:@"Background.png"], 1);
    
    NSString *fileName = @"test";
    fileName = [fileName stringByAppendingPathExtension:@"jpeg"];
    [mc addAttachmentData:jpegData mimeType:@"image/jpeg" fileName:fileName];
    
    [mc setSubject:@"email subject"];
    [mc setMessageBody:htmlMsg isHTML:YES];
    
    
    [self presentViewController:mc animated:YES completion:NULL];
    mc.mailComposeDelegate = self;
  
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
    //[self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)editData:(id)sa {
    
}
-(void)saveData:(id)sa {
    NSInteger selectedSegmentIndex =_chkBoxPriority.selectedSegmentIndex;
    NSString *strPriority = [NSString stringWithFormat:@"P%ld",(long)selectedSegmentIndex+1];
    NSLog(@"%@",strPriority);
    if (self.txtFldCost.text.length > 0 && self.txtFldDesignation.text.length > 0 && self.txtViewUserStory.text.length > 0 ) {
        UserStoriesModel *userStory = [UserStoriesModel initWithTitle:_detailItem.strProjectTitle designation:self.txtFldDesignation.text priority:strPriority cost:self.txtFldCost.text userStory:self.txtViewUserStory.text];
        [[DBSingletonFactory getSharedInstance]saveUserStory:userStory];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UserStoriesViewController *userStoriesVC = [storyboard instantiateViewControllerWithIdentifier:@"UserStoriesVC"];
        [userStoriesVC configuerView:userStory];
        NSDictionary *dict = [NSDictionary getDictionaryForUserStory:userStory];
        NSLog(@"%@",dict);
        
        [FileIOHelper writeToTextFile:dict];
        [self presentViewController:userStoriesVC animated:YES completion:nil];
        

    }
    
    
    [self.navigationController popViewControllerAnimated:YES ];
    //[self sendMail:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    [Flurry logEvent:@"DetailViewController"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
