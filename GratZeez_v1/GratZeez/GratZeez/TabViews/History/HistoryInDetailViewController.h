//
//  HistoryInDetailViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 30/12/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
@interface HistoryInDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lbl_From;
@property (strong, nonatomic) IBOutlet UILabel *lbl_To;
@property (strong, nonatomic) IBOutlet UILabel *lbl_user;
@property (strong, nonatomic) NSMutableArray *detailHistoryDataArray;
@property (strong, nonatomic) IBOutlet UIView *view_sender;
@property (strong, nonatomic) IBOutlet UIView *view_serviceProvider;
@property (strong, nonatomic) IBOutlet UILabel *lbl_serviceProvider;
@property (strong, nonatomic) IBOutlet UITableView *table_sender;
@property (strong, nonatomic) IBOutlet UITableView *table_receiver;
@property (assign,nonatomic) BOOL ischarity;
@end
