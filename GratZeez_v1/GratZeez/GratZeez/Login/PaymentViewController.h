//
//  PaymentViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 15/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PayPalMobile.h"
#import "GratuityViewController.h"
#import "HelpViewController.h"
#import "RadioButtonView.h"
#import "Constant.h"
#import "HistoryViewController.h"


@interface PaymentViewController : UIViewController <UITextFieldDelegate,PayPalPaymentDelegate,UIPopoverControllerDelegate,RadioButtonDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    int paymentComplete;
    IBOutlet UILabel *lblDoNotFallBelow,*lblRechargeAmount;
    RadioButtonView *paymentRadioGroup;
}

@property(nonatomic) int paymentComplete;
@property(nonatomic,retain) NSString *firstName;
@property(nonatomic,retain) NSString *lastName;
@property(nonatomic,retain) NSString *contactNumber;
@property(nonatomic,retain) NSString *email;
@property(nonatomic,retain) NSString *password;
@property (strong, nonatomic) IBOutlet UILabel *paymentMethodLbl;
@property (strong, nonatomic) IBOutlet UILabel *lbl_autorecharge;
@property (strong, nonatomic) IBOutlet UILabel *lbl_fund;
@property (strong, nonatomic) IBOutlet UIImageView *proImage;
@property (strong, nonatomic) IBOutlet UIButton *uploadImgButton;
- (IBAction)saveImageAction:(id)sender;

- (IBAction)btnContinueAction:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *vie_btn;

@property (strong, nonatomic) IBOutlet UIToolbar *completeProToolbar;

@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@property(nonatomic, strong, readwrite) PayPalPayment *completedPayment;


@property (weak, nonatomic) IBOutlet UILabel *lblUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtFund;
@property (weak, nonatomic) IBOutlet UITextField *txtFallBelowAmount;
@property (weak, nonatomic) IBOutlet UITextField *txtRechargeAmount;
@property (strong, nonatomic) IBOutlet UIButton *btn_imagesave;
@property (strong, nonatomic) IBOutlet UIButton *btn_imageUpload;
- (IBAction)showImagePicker:(id)sender;

@property (weak, nonatomic) IBOutlet UISwitch *SwitchFundReplenishment;
- (IBAction)switchAction:(id)sender;

@end
