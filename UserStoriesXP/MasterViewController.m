//
//  MasterViewController.m
//  UserStoriesXP
//
//  Created by ANUJ DESHMUKH on 11/18/14.
//  Copyright (c) 2014 DESHMUKH. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "ProjectProfileViewController.h"
#import "DBSingletonFactory.h"
#import "Flurry.h"


@interface MasterViewController ()

@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [Flurry logEvent:@"MastersView"];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background.png"]];
    self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    self.title = @"User Stories";
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.objects = [[NSMutableArray alloc]init];
   
    
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    if (self.objects.count > 0) {
        [self.objects removeAllObjects];
    }
    [self.objects addObjectsFromArray:[[DBSingletonFactory getSharedInstance]getAllProjectProfiles]];
    
    [self.tableView reloadData];
}
    

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ProjectProfileViewController *projectProfileVC = [storyboard instantiateViewControllerWithIdentifier:@"ProjectProfileVC"];
    [projectProfileVC setModalPresentationStyle:UIModalPresentationFullScreen];
    [self presentViewController:projectProfileVC animated:YES completion:nil];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    ProjectProfileModel *projectProfile = [self.objects objectAtIndex:indexPath.row];
    cell.textLabel.text = projectProfile.strProjectTitle;
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

@end
