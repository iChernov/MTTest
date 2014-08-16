//
//  ICTVehicleTableViewCell.h
//  MTTest
//
//  Created by Ivan Chernov on 16/08/14.
//  Copyright (c) 2014 iChernov. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *ICTVehicleCellReuseIdentifier;

@interface ICTVehicleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *externalConditionView;
@property (weak, nonatomic) IBOutlet UIImageView *internalConditionView;

- (void)setExternalCondition:(NSString *)conditionDescription;
- (void)setInternalCondition:(NSString *)conditionDescription;
@end
