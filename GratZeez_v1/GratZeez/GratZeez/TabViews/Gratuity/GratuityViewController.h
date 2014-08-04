//
//  GratuityViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 14/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaymentViewController.h"
#import "HelpViewController.h"
#import  "DYRateView.h"
#import "ViewRateViewController.h"
#import "Comment_UserListViewController.h"
@interface GratuityViewController : UIViewController<UITabBarControllerDelegate,UITabBarDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UILabel *lbl_grauity;
    DYRateView *rateView;
    BOOL ischarity;
    NSString *rate_no;
    IBOutlet UILabel *lbl_totalGratuity;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgProfile;
@property (weak, nonatomic) IBOutlet UILabel *lblWelcome;

@property (strong, nonatomic) IBOutlet UILabel *lbl_gratuitydisplay;
@property (strong, nonatomic) IBOutlet UILabel *lbl_lastTransaction;
@property (strong, nonatomic) IBOutlet UIView *view_sender;

@property (strong, nonatomic) IBOutlet UIView *view_serviceProvider;
@property (strong, nonatomic) IBOutlet UIImageView *imgProfile_serviceProvider;
@property (strong, nonatomic) IBOutlet UILabel *lblWelcome_serviceProvider;
@property (strong, nonatomic) IBOutlet UITextField *txt_serviceProviderTotalGratuity;
@property (strong, nonatomic) IBOutlet UITableView *tableview_serviceProvider;
@property (strong, nonatomic) IBOutlet UIToolbar *gratuityToolbar;
@property (strong, nonatomic) IBOutlet UILabel *lbl_currentBalance;
@property (strong, nonatomic) IBOutlet UITextField *txt_currentBalance;
- (IBAction)ViewCommentedUserList:(id)sender;
- (IBAction)viewRating:(id)sender;
@property(strong,nonatomic) NSMutableArray *SPLastTransactionDataArray;
@end
