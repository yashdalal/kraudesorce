//
//  LocationListTableViewController.m
//  KraudeSorce
//
//  Created by Yash Dalal on 4/24/16.
//  Copyright © 2016 Yash Dalal. All rights reserved.
//
#import "Location.h"
#import "LocationListTableViewController.h"
#import "ViewController.h"

@interface LocationListTableViewController ()

@end

@implementation LocationListTableViewController

AppDelegate *appDelegate;


- (void)viewDidLoad {
    appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.locations = appDelegate.locations;
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.locations count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LocationListCell" forIndexPath:indexPath];
    
    Location *location = (self.locations)[indexPath.row];
    cell.textLabel.text = location.name;
    cell.detailTextLabel.text = location.busyLevel;
        
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"displayLocation"]){
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        
        ViewController *vc = (ViewController *)[segue destinationViewController];
        
        Location *current = [self.locations objectAtIndex:ip.row];
        
        vc.lName = current.name;
        vc.rat = current.busyLevel;
        NSLog(@"%@ %@", current.name, current.image);
        vc.imageTitle = current.image;
    }
}


@end
