//
//  HistoryViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 14/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HelpViewController.h"
#import "GratuityReceiver.h"
#import "GpsSearchViewController.h"
#import "MyFavoriteListViewController.h"
#import "HistoryInDetailViewController.h"
#import "HistoryDetailViewController.h"
#import <CoreText/CoreText.h>
@interface HistoryViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
{
    NSMutableArray *historyDataArray;
    BOOL isCharity;
}
@property (strong, nonatomic) IBOutlet UILabel *lbl_titleHistory;
@property (strong, nonatomic) IBOutlet UIView *ServiceProviderView;
@property (strong, nonatomic) IBOutlet UIView *SenderView;
//@property (strong,nonatomic) HistoryInDetailViewController *historyVC;
@property (strong,nonatomic) HistoryDetailViewController *historyVC;
//@property (strong,nonatomic) IBOutlet UITableView *tableView;
//
//@property (strong,nonatomic) NSArray *receiverArray;
//@property (strong,nonatomic) NSMutableArray *filteredReceiverArray;
//@property IBOutlet UISearchBar *gratuityReceiverSearchBar;
@property (strong,nonatomic) IBOutlet UITableView *historyTable;
@property (strong, nonatomic) IBOutlet UILabel *searchLbl;
@property (strong, nonatomic) IBOutlet UILabel *headingLbl;
@property (strong, nonatomic) IBOutlet UIButton *btn_locateNearBy;
@property (strong, nonatomic) IBOutlet UIButton *btn_scanBarCode;
@property (strong, nonatomic) IBOutlet UIButton *btn_inviteUser;
@property (strong, nonatomic) IBOutlet UIButton *btn_Favorite;

@property (weak, nonatomic) IBOutlet UITextField *txtSearchUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtSearchNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtSearchEstablishment;
@property (strong, nonatomic) IBOutlet UIToolbar *mainToolBar;

- (IBAction)myFavoriteAction:(id)sender;


@end
