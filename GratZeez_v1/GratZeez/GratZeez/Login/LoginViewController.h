//
//  LoginViewController.h
//  GratZeez
//
//  Created by cloudZon Infosoft on 14/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "Constant.h"
#import "HistoryViewController.h"
#import "MenuViewController.h"
#import "GratuityViewController.h"

@interface LoginViewController : UIViewController <UITextFieldDelegate> {
    CGPoint mainViewPoint;
}

- (IBAction)SelectionAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnServiceProvider;
@property (strong, nonatomic) IBOutlet UIButton *btnCustomer;
- (IBAction)btnServiceProviderAction:(id)sender;
- (IBAction)btnCustomerAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lbl_register;
@property (strong, nonatomic) IBOutlet UILabel *lbl_serviceProvider;
@property (strong, nonatomic) IBOutlet UILabel *lbl_customer;

@property (strong, nonatomic) IBOutlet UILabel *lbl_facebook;
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@property (strong, nonatomic) IBOutlet UIView *SelectionView;

@property (weak, nonatomic) IBOutlet UIButton *btnFBConnect;

@end
