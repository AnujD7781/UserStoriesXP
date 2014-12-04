//
//  ProjectProfileViewController.m
//  UserStories
//
//  Created by ANUJ DESHMUKH on 10/17/14.
//  Copyright (c) 2014 DESHMUKH. All rights reserved.
//

#import "ProjectProfileViewController.h"
#import "DBSingletonFactory.h"
#import "Flurry.h"

@interface ProjectProfileViewController ()

@end

@implementation ProjectProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    [Flurry logEvent:@"ProjectProfile"];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];

    arrProjects = [[NSMutableArray alloc]init];
    arrStakeHolders = [[NSMutableArray alloc]init];
    ABAuthorizationStatus status = ABAddressBookGetAuthorizationStatus();
    
    if (status == kABAuthorizationStatusDenied) {
        // if you got here, user had previously denied/revoked permission for your
        // app to access the contacts, and all you can do is handle this gracefully,
        // perhaps telling the user that they have to go to settings to grant access
        // to contacts
        
        [[[UIAlertView alloc] initWithTitle:nil message:@"This app requires access to your contacts to function properly. Please visit to the \"Privacy\" section in the iPhone Settings app." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        return;
    }
    
    CFErrorRef error = NULL;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    if (error) {
        NSLog(@"ABAddressBookCreateWithOptions error: %@", CFBridgingRelease(error));
        if (addressBook) CFRelease(addressBook);
        return;
    }
    
    if (status == kABAuthorizationStatusNotDetermined) {
        
        // present the user the UI that requests permission to contacts ...
        
        ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error) {
            if (error) {
                NSLog(@"ABAddressBookRequestAccessWithCompletion error: %@", CFBridgingRelease(error));
            }
            
            if (granted) {
                // if they gave you permission, then just carry on
                
                [self listPeopleInAddressBook:addressBook];
            } else {
                // however, if they didn't give you permission, handle it gracefully, for example...
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    // BTW, this is not on the main thread, so dispatch UI updates back to the main queue
                    
                    [[[UIAlertView alloc] initWithTitle:nil message:@"This app requires access to your contacts to function properly. Please visit to the \"Privacy\" section in the iPhone Settings app." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                });
            }
            
            if (addressBook) CFRelease(addressBook);
        });
        
    } else if (status == kABAuthorizationStatusAuthorized) {
        [self listPeopleInAddressBook:addressBook];
        if (addressBook) CFRelease(addressBook);
    }
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)SaveProjectProfile:(id)sender {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
    [dictionary setValue:txtFldDesignation.text forKey:@"Designation"];
    [dictionary setValue:txtFldProjectName.text forKey:@"ProjectTitle"];
    [dictionary setValue:txtViewDescription.text forKey:@"Description"];
    if (txtFldDesignation.text.length > 0 && txtFldProjectName.text.length > 0 && txtViewDescription.text.length > 0) {
        ProjectProfileModel *projecProfile = [ProjectProfileModel initWithTitle:txtFldProjectName.text designation:txtFldDesignation.text description:txtViewDescription.text stakeHolders:arrStakeHolders];
        [[DBSingletonFactory getSharedInstance]saveProjectProfile:projecProfile];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)listPeopleInAddressBook:(ABAddressBookRef)addressBook
{
    NSInteger numberOfPeople = ABAddressBookGetPersonCount(addressBook);
    NSArray *allPeople = CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(addressBook));
    
    for (NSInteger i = 0; i < numberOfPeople; i++) {
        ABRecordRef person = (__bridge ABRecordRef)allPeople[i];
        
        NSString *firstName = CFBridgingRelease(ABRecordCopyValue(person, kABPersonFirstNameProperty));
        NSString *lastName  = CFBridgingRelease(ABRecordCopyValue(person, kABPersonLastNameProperty));
        ABMultiValueRef emailMultiValue = ABRecordCopyValue(person, kABPersonEmailProperty);
        NSArray *emailAddresses = (__bridge NSArray *)ABMultiValueCopyArrayOfAllValues(emailMultiValue) ;
        CFRelease(emailMultiValue);
        NSMutableString *startString = [NSMutableString stringWithString:@""];
        
        for (NSString *str in emailAddresses) {
            [startString appendString:[NSString stringWithFormat:@" %@",str]];
        }
        NSLog(@"Name:%@ %@, %@", firstName, lastName, emailAddresses);
        NSMutableDictionary *dictAdress = [[NSMutableDictionary alloc]init];
        
        
        
        ABMultiValueRef phoneNumbers = ABRecordCopyValue(person, kABPersonPhoneProperty);
        
        CFIndex numberOfPhoneNumbers = ABMultiValueGetCount(phoneNumbers);
        for (CFIndex i = 0; i < numberOfPhoneNumbers; i++) {
            NSString *phoneNumber = CFBridgingRelease(ABMultiValueCopyValueAtIndex(phoneNumbers, i));
            NSLog(@"  phone:%@", phoneNumber);
        }
        [dictAdress setObject:firstName forKey:@"FirstName"];
        [dictAdress setObject:lastName  forKey:@"LastName"];
        [dictAdress setObject:startString forKey:@"EmailId"];
        //[dictAdress setObject:startString forKey:@"PhoneNo"];
        [arrProjects addObject:dictAdress];
        CFRelease(phoneNumbers);
        
        NSLog(@"=============================================");
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;    //count of section
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [arrProjects count];    //count number of row from counting array hear cataGorry is An Array
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //NSString *sectionName;
  
    return @"Add stakeholders";
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:MyIdentifier] ;
    }
    
    // Here we use the provided setImageWithURL: method to load the web image
    // Ensure you use a placeholder image otherwise cells will be initialized with no image
    NSDictionary *dict = [arrProjects objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"FirstName"], [dict objectForKey:@"LastName"]];
    // cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",[dict objectForKey:@"FirstName"], [dict objectForKey:@"LastName"]];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[dict objectForKey:@"EmailId"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 //Pushing next view
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSDictionary *dict = [arrProjects objectAtIndex:indexPath.row];
    [arrStakeHolders addObject:[dict objectForKey:@"EmailId"]];
    if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
}


@end
