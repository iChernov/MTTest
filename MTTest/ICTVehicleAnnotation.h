//
//  ICTVehicleAnnotation.h
//  MTTest
//
//  Created by Ivan Chernov on 16/08/14.
//  Copyright (c) 2014 iChernov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

extern NSString *ICTVehicleAnnotationReuseIdentifier;

@interface ICTVehicleAnnotation : NSObject <MKAnnotation>
@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *subtitle;
@property (readonly, nonatomic) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *conditionCode;

- (id)initWithTitle:(NSString *)title andSubtitle:(NSString *)subtitle andLocation:(CLLocationCoordinate2D)location withConditionCode:(NSString *)conditionCode;
- (MKAnnotationView *)annotationView;

@end
