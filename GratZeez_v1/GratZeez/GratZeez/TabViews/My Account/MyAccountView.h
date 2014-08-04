//
//  MyAccountView.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 31/12/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"
#import "SenderHistoryViewController.h"
#import "Sender_HistoryViewController.h"
#import "EditProfileViewController.h"
#import "RechargeViewController.h"
#import "ServiceProviderEditProfileViewController.h"
@interface MyAccountView : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UIView *view_sender;
@property (strong, nonatomic) IBOutlet UIView *view_serviceProvider;
@property (strong, nonatomic) IBOutlet UITableView *tableview_sender;
@property (strong, nonatomic) IBOutlet UITableView *tableview_ServiceProvider;
@property (strong, nonatomic) IBOutlet UIToolbar *myAccountToolbar;
@end
