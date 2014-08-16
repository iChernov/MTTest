//
//  ICTMapViewController.m
//  MTTest
//
//  Created by Ivan Chernov on 16/08/14.
//  Copyright (c) 2014 iChernov. All rights reserved.
//

#import "ICTMapViewController.h"
#import "ICTListTableViewController.h"
#import "ICTVehicleAnnotation.h"

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
    [self locateUser];
    
    _vehiclesToShowArray = listViewController.vehiclesArray;
    
    for (NSDictionary *vehicleDictionary in _vehiclesToShowArray) {
        CLLocationCoordinate2D location = CLLocationCoordinate2DMake([vehicleDictionary[@"coordinates"][1] doubleValue], [vehicleDictionary[@"coordinates"][0] doubleValue]);
        
        int carExteriorCode = [vehicleDictionary[@"exterior"] isEqualToString:@"GOOD"] ? 1 : 0;
        int carInteriorCode = [vehicleDictionary[@"interior"] isEqualToString:@"GOOD"] ? 1 : 0;
        NSString *carConditionCode = [NSString stringWithFormat:@"%d%d", carExteriorCode, carInteriorCode];
        
        ICTVehicleAnnotation *annotation = [[ICTVehicleAnnotation alloc] initWithTitle:vehicleDictionary[@"name"]
                                                                           andSubtitle:vehicleDictionary[@"address"]
                                                                           andLocation:location
                                                                     withConditionCode:carConditionCode];
        [self.mapView addAnnotation:annotation];
    }
}

- (void)locateUser {
    CLLocationCoordinate2D coordinate = [[_locationManager location] coordinate];;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
}

- (IBAction)centerMapOnUserButtonClicked:(id)sender {
    [self locateUser];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[ICTVehicleAnnotation class]]) {
        ICTVehicleAnnotation *carAnnotation = (ICTVehicleAnnotation *)annotation;
        MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:ICTVehicleAnnotationReuseIdentifier];
        if (annotationView == nil) {
            annotationView = carAnnotation.annotationView;
        } else {
            annotationView.annotation = carAnnotation;
        }
        return annotationView;
    } else
        return nil;
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
