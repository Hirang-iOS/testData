//
//  SearchResultCell.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 23/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "SearchResultCell.h"

@implementation SearchResultCell

@synthesize lblFirst_name;
@synthesize lblLast_name;
@synthesize lblUsername;
@synthesize lblNumber;
@synthesize lblEstablishment;
@synthesize imgIcon;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
