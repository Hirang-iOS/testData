//
//  HistoryDetailViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 15/01/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//Working Histroy

#import <UIKit/UIKit.h>
#import "Constant.h"
@interface HistoryDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *view_serviceProvider;
@property (strong, nonatomic) IBOutlet UILabel *lbl_From;
@property (strong, nonatomic) IBOutlet UILabel *lbl_To;
@property (strong, nonatomic) IBOutlet UILabel *lbl_user;
@property (strong, nonatomic) NSMutableArray *detailHistoryDataArray;
@property (strong, nonatomic) IBOutlet UILabel *lbl_serviceProvider;
@property (strong, nonatomic) IBOutlet UITableView *table_serviceProvider;
@property (strong, nonatomic) IBOutlet UIView *view_sender;
@property (strong, nonatomic) IBOutlet UITableView *table_sender;
@property (assign,nonatomic) BOOL ischarity;
@property (strong, nonatomic) IBOutlet UIToolbar *historyDetailToolbar;
@end
