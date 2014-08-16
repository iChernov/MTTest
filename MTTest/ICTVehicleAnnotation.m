//
//  ICTVehicleAnnotation.m
//  MTTest
//
//  Created by Ivan Chernov on 16/08/14.
//  Copyright (c) 2014 iChernov. All rights reserved.
//

#import "ICTVehicleAnnotation.h"

NSString *ICTVehicleAnnotationReuseIdentifier = @"ICTVehicleAnnotationReuseIdentifier";

@implementation ICTVehicleAnnotation
- (id)initWithTitle:(NSString *)title andSubtitle:(NSString *)subtitle  andLocation:(CLLocationCoordinate2D)location withConditionCode:(NSString *)conditionCode {
    self = [super init];
    if(self){
        _title = title;
        _subtitle = subtitle;
        _coordinate = location;
        _conditionCode = conditionCode;
    }
    return self;
}

- (MKAnnotationView *)annotationView {
    MKAnnotationView *annotationView = [[MKAnnotationView alloc] initWithAnnotation:self reuseIdentifier:ICTVehicleAnnotationReuseIdentifier];
    annotationView.enabled = YES;
    annotationView.canShowCallout = YES;
    /* 
     * probably later we will add some more information
     * annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
     */
    annotationView.image = [UIImage imageNamed:[NSString stringWithFormat:@"mapCar%@", _conditionCode]];
    return annotationView;
}
@end
