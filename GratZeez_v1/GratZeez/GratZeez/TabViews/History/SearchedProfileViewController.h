//
//  SearchedProfileViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 30/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYRateView.h"
#import "HelpViewController.h"
#import "InvoiceViewController.h"
@interface SearchedProfileViewController : UIViewController<UITextFieldDelegate,UISearchBarDelegate,DYRateViewDelegate,UITextViewDelegate,UIAlertViewDelegate>
{
    UIImageView *proImg;
    UILabel *lblusername,*lblFirst_name,*lblLast_name,*lblNumber,*lblEstablishment;
    NSInteger cellId;
    UITextField *txtAmount;
    CGPoint mainViewCenter;;
    IBOutlet UIView *txtview;
    DYRateView *rateView;
    NSString *serviceProviderUserid,*organizationId;
    NSString *rateString;
    BOOL isFavorite;
    UIAlertView *confirmAlert;
    
    IBOutlet UIButton *btn_calculateGratuity;
}
@property (strong, nonatomic) IBOutlet UILabel *gratzeezPercentageLabel;
@property(assign,nonatomic)NSInteger amountToCharity;
@property (strong, nonatomic) IBOutlet UILabel *lbl_amount_to_charity;
@property(nonatomic) BOOL isFavorite;
@property (weak, nonatomic) IBOutlet UITextView *txtComment;
@property(nonatomic)NSInteger cellId;
@property(nonatomic,retain)IBOutlet UIImageView *proImg;
@property(nonatomic,retain)IBOutlet UILabel *lblusername,*lblFirst_name,*lblLast_name,*lblNumber,*lblEstablishment;
@property(nonatomic,retain)IBOutlet UITextField *txtAmount;
@property (strong, nonatomic) IBOutlet UIButton *btn_favorite;
@property (strong, nonatomic) IBOutlet UILabel *lbl_favorite;
@property (strong, nonatomic) IBOutlet UILabel *lbl_rate;
@property (strong, nonatomic) IBOutlet UILabel *lbl_gratuity;
- (IBAction)calculateGratuityAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *view_invoice;
@property (strong, nonatomic) IBOutlet UIToolbar *searchedToolbar;
@property (strong, nonatomic) IBOutlet UIView *view_rate;
@property(strong,nonatomic) NSString *individualRate;
- (IBAction)sendGratuity:(id)sender;
- (IBAction)addFavoriteAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txt_invoice;
@property (strong, nonatomic) IBOutlet UITextField *txt_sendPercentage;
@property (strong, nonatomic) IBOutlet UILabel *lbl_count;

@property (strong, nonatomic) IBOutlet UIView *view_btn;

@end
