//
//  WorkDetailCell.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 27/11/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkDetailCell : UITableViewCell
{
    
}
@property (strong, nonatomic) IBOutlet UILabel *lblOrganization;
@property (strong, nonatomic) IBOutlet UILabel *lblLandmark;
@property (strong, nonatomic) IBOutlet UILabel *lblAddress;
@property (strong, nonatomic) IBOutlet UILabel *lblCity;
@property (strong, nonatomic) IBOutlet UILabel *lblState;

@end