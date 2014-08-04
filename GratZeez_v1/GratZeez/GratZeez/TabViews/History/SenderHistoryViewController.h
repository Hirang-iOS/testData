//
//  SenderHistoryViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 31/12/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HistoryInDetailViewController.h"
#import "HistoryDetailViewController.h"
#import "Constant.h"
@interface SenderHistoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property(strong,nonatomic) NSMutableArray *senderHistoryDataArray;
@property (strong, nonatomic) IBOutlet UITableView *sender_table;

@end
