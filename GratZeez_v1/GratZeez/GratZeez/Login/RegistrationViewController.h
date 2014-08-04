//
//  RegistrationViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 15/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButtonView.h"
#import "HelpViewController.h"
//#import "PaymentViewController.h"
@class RadioButtonView;
@interface RegistrationViewController : UIViewController<UITextFieldDelegate>{

    IBOutlet UILabel *lbl_registerAS;
    RadioButtonView *genderButton;
    IBOutlet UILabel *lbl_agree;    UITextField *txtEmail;
   IBOutlet UINavigationBar *regNavBar;
    IBOutlet UINavigationItem *regNavItem;
    BOOL textFlag,textFlag1;
    CGPoint center;
    int direction;
    int shakes;
}
- (IBAction)backButtonAction:(id)sender;
@property(strong,nonatomic)IBOutlet UILabel *lbl_create;
@property(strong,nonatomic)UIBarButtonItem *backbtn;
@property(nonatomic,retain)NSString *gender;
@property(nonatomic,retain)UINavigationItem *regNavItem;
@property(nonatomic,assign) NSInteger selectedGenderIndex;
@property (weak, nonatomic) IBOutlet UIButton *btnAgreeTerms;
@property (weak, nonatomic) IBOutlet UIButton *btnServiceProvider;

@property (weak, nonatomic) IBOutlet UITextField *txtFirstname;
@property (weak, nonatomic) IBOutlet UITextField *txtLastname;
@property (weak, nonatomic) IBOutlet UITextField *txtContactNumber;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtRePassword;
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property(assign,nonatomic) BOOL fromBrowser;
- (IBAction)btnAgreeTermsAction:(id)sender;
- (IBAction)btnServiceProviderAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnCustomer;


@end
