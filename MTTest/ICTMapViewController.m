//
//  ICTMapViewController.m
//  MTTest
//
//  Created by Ivan Chernov on 16/08/14.
//  Copyright (c) 2014 iChernov. All rights reserved.
//

#import "ICTMapViewController.h"
#import "ICTListTableViewController.h"

@interface ICTMapViewController ()
@property NSArray *vehiclesToShowArray;
@property CLLocationManager *locationManager;
@end

@implementation ICTMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.locationManager = [[CLLocationManager alloc] init];
    self.mapView.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    ICTListTableViewController *listViewController = [self.tabBarController.viewControllers objectAtIndex:0];
    _locationManager.delegate = self;
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [_locationManager startUpdatingLocation];
    _vehiclesToShowArray = listViewController.vehiclesArray;
    
    for (NSDictionary *vehicleDictionary in _vehiclesToShowArray) {
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        CLLocationDegrees latitude = [vehicleDictionary[@"coordinates"][1] doubleValue];
        CLLocationDegrees longitude = [vehicleDictionary[@"coordinates"][0] doubleValue];
        
        point.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        point.title = vehicleDictionary[@"name"];
        point.subtitle = vehicleDictionary[@"address"];
        
        [self.mapView addAnnotation:point];
    }
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    if ([newLocation distanceFromLocation: oldLocation] > 15) {
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(newLocation.coordinate, 800, 800);
        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    }
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    for (NSDictionary *vehicleDictionary in _vehiclesToShowArray) {
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        CLLocationDegrees latitude = [vehicleDictionary[@"coordinates"][0] doubleValue];
        CLLocationDegrees longitude = [vehicleDictionary[@"coordinates"][1] doubleValue];

        point.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        point.title = vehicleDictionary[@"name"];
        point.subtitle = vehicleDictionary[@"address"];
        
        [self.mapView addAnnotation:point];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
