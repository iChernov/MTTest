//
//  ICTListTableViewController.m
//  MTTest
//
//  Created by Ivan Chernov on 16/08/14.
//  Copyright (c) 2014 iChernov. All rights reserved.
//

#import "ICTListTableViewController.h"
#import "AFNetworking.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "ICTVehicleTableViewCell.h"

static NSString * const BaseURLString = @"http://redirect.mytaxi.net/car2go/vehicles.json";
static const int kCellHeightValue = 70.0;

@interface ICTListTableViewController ()
@end

@implementation ICTListTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 50)];
    footer.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = footer;
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self.tableView registerClass:[ICTVehicleTableViewCell class]
           forCellReuseIdentifier:ICTVehicleCellReuseIdentifier];
    [self loadVehicles];
}

- (void)loadVehicles {
    __weak __typeof(&*self)weakSelf = self;

    NSURL *url = [NSURL URLWithString:BaseURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.tabBarController.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading...";
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *vehiclesToAdd = responseObject[@"placemarks"];
        [hud hide:YES];
        [weakSelf refreshDataWithVechicles:vehiclesToAdd];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"Internet connection failed";
        [hud hide:YES afterDelay:3];
    }];
    [operation start];
}

- (void)refreshDataWithVechicles:(NSArray *)vehiclesArray {
    _vehiclesArray = vehiclesArray;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _vehiclesArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ICTVehicleTableViewCell *cell = (ICTVehicleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:ICTVehicleCellReuseIdentifier forIndexPath:indexPath];
    if(cell == nil) {
        cell = [[ICTVehicleTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ICTVehicleCellReuseIdentifier];
    }
    cell.nameLabel.text = _vehiclesArray[indexPath.row][@"name"];
    cell.addressLabel.text = _vehiclesArray[indexPath.row][@"address"];
    [cell setExternalCondition:_vehiclesArray[indexPath.row][@"exterior"]];
    [cell setInternalCondition:_vehiclesArray[indexPath.row][@"interior"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeightValue;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
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
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
