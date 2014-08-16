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

- (void)awakeFromNib
{
    
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setExternalCondition:(NSString *)conditionDescription {
    if ([conditionDescription isEqualToString:@"GOOD"]) {
        self.externalConditionProgressView.progress = 0.8;
    }
    if ([conditionDescription isEqualToString:@"NORMAL"]) {
        self.externalConditionProgressView.progress = 0.55;
    }
    if ([conditionDescription isEqualToString:@"UNACCEPTABLE"]) {
        self.externalConditionProgressView.progress = 0.25;
    }
}

- (void)setInternalCondition:(NSString *)conditionDescription {
    if ([conditionDescription isEqualToString:@"GOOD"]) {
        self.internalConditionProgressView.progress = 0.8;
    }
    if ([conditionDescription isEqualToString:@"NORMAL"]) {
        self.internalConditionProgressView.progress = 0.55;
    }
    if ([conditionDescription isEqualToString:@"UNACCEPTABLE"]) {
        self.internalConditionProgressView.progress = 0.25;
    }}

@end
