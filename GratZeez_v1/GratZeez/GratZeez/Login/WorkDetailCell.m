//
//  WorkDetailCell.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 27/11/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "WorkDetailCell.h"

@implementation WorkDetailCell
@synthesize lblState,lblCity,lblLandmark,lblAddress,lblOrganization;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
