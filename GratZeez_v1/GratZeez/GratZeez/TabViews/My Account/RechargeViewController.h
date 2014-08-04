//
//  RechargeViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 03/01/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButtonView.h"
#import "PayPalMobile.h"
#import <QuartzCore/QuartzCore.h>
#import "Constant.h"
@interface RechargeViewController : UIViewController<RadioButtonDelegate,PayPalPaymentDelegate,UITextFieldDelegate>
{
    RadioButtonView *paymentRadioGroup;
     int paymentComplete;
}
@property (strong, nonatomic) IBOutlet UITextField *txtFund;
- (IBAction)continueAction:(id)sender;
@property(nonatomic, strong, readwrite) NSString *environment;
@property(nonatomic, assign, readwrite) BOOL acceptCreditCards;
@property(nonatomic, strong, readwrite) PayPalPayment *completedPayment;
@property (strong, nonatomic) IBOutlet UITextField *txt_currentBalance;
@property (strong, nonatomic) IBOutlet UILabel *lbl_rechargewith;
@property (strong, nonatomic) IBOutlet UILabel *lbl_currentBal;
@property (strong, nonatomic) IBOutlet UILabel *lbl_amount;
@property (strong, nonatomic) IBOutlet UIToolbar *rechargeToolbar;

@end
