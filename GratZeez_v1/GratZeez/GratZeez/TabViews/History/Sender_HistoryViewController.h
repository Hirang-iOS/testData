//
//  Sender_HistoryViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 15/01/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//working History

#import <UIKit/UIKit.h>
#import "HistoryDetailViewController.h"
#import "Constant.h"
@interface Sender_HistoryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic) NSMutableArray *senderHistoryDataArray;
@property (strong, nonatomic) IBOutlet UITableView *sender_table;
@property (strong, nonatomic) IBOutlet UIToolbar *senderHistoryToolbar;

@end
