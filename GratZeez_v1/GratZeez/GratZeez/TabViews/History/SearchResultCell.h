//
//  SearchResultCell.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 23/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultCell : UITableViewCell {
    
    IBOutlet UILabel *lblFirst_name;
    IBOutlet UILabel *lblLast_name;
    IBOutlet UILabel *lblUsername;
    IBOutlet UILabel *lblNumber;
    IBOutlet UILabel *lblEstablishment;
    
    IBOutlet UIImageView *imgIcon;
}

@property(nonatomic,retain) IBOutlet UILabel *lblFirst_name;
@property(nonatomic,retain) IBOutlet UILabel *lblLast_name;
@property(nonatomic,retain) IBOutlet UILabel *lblUsername;
@property(nonatomic,retain) IBOutlet UILabel *lblNumber;
@property(nonatomic,retain) IBOutlet UILabel *lblEstablishment;

@property(nonatomic,retain) IBOutlet UIImageView *imgIcon;

@end
