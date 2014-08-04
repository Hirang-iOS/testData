//
//  MyFavoriteListViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 28/11/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchResultCell.h"
#import "SearchedProfileViewController.h"
#import "ASIFormDataRequest.h"
#import "Constant.h"
#import "DYRateView.h"
@interface MyFavoriteListViewController : UITableViewController
{
    NSMutableArray *favArray;
    IBOutlet UITableView *favTable;
}
@property (strong, nonatomic) IBOutlet UIToolbar *favToolbar;
@property(strong,nonatomic) NSMutableArray *favArray;
@end
