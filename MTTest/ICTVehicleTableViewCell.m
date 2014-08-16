//
//  ICTVehicleTableViewCell.m
//  MTTest
//
//  Created by Ivan Chernov on 16/08/14.
//  Copyright (c) 2014 iChernov. All rights reserved.
//

#import "ICTVehicleTableViewCell.h"

NSString *ICTVehicleCellReuseIdentifier = @"ICTVehicleCellReuseIdentifier";

@implementation ICTVehicleTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"ICTVehicleTableViewCell" owner:self options:nil];
        self = nibArray[0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setExternalCondition:(NSString *)conditionDescription {
    if ([conditionDescription isEqualToString:@"GOOD"]) {
        self.externalConditionView.image = [UIImage imageNamed:@"exterior_good"];
    }
    if ([conditionDescription isEqualToString:@"UNACCEPTABLE"]) {
        self.externalConditionView.image = [UIImage imageNamed:@"exterior_bad"];
    }
}

- (void)setInternalCondition:(NSString *)conditionDescription {
    if ([conditionDescription isEqualToString:@"GOOD"]) {
        self.internalConditionView.image = [UIImage imageNamed:@"interior_good"];
    }
    if ([conditionDescription isEqualToString:@"UNACCEPTABLE"]) {
        self.internalConditionView.image = [UIImage imageNamed:@"interior_bad"];
    }}

@end
