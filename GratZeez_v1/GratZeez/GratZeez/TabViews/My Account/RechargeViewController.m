//
//  RechargeViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 03/01/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import "RechargeViewController.h"

@interface RechargeViewController ()

@end

@implementation RechargeViewController
@synthesize txtFund,txt_currentBalance,lbl_amount,lbl_currentBal,lbl_rechargewith,rechargeToolbar;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *option=@[@"Credit Card/PayPal",@"Bank Account"];
    paymentRadioGroup=[[RadioButtonView alloc]initWithPayPalFrame:CGRectMake(0, 128, 320, 40) andOptions:option andColumns:2 tag:1];
    paymentRadioGroup.delegate=self;
    [paymentRadioGroup setPayPalSelected:0];
    [self.view addSubview:paymentRadioGroup];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    self.title=@"Recharge Account";
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    
    rechargeToolbar.frame=CGRectMake(0, 524, 320, 44);
    [self.view addSubview:rechargeToolbar];
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 21)];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *btnitem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    rechargeToolbar.items=@[btnitem];
    [rechargeToolbar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];

    [self addLeftMenuButtonWithImage:[UIImage imageNamed:@"menu_icon"]];
    [self addrightMenuButtonWithImage:[UIImage imageNamed:@"help"]];
    
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:rightRecognizer];
    // Do any additional setup after loading the view from its nib.
}

-(IBAction)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setTitle:(NSString *)title {
    //    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont fontWithName:@"Garamond 3 SC" size:20.0];
        titleView.textColor = [UIColor whiteColor];
        self.navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}
-(void)getCurrentBalance:(void (^)(BOOL result)) return_block{
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLGetSenderCurrentBalance]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    NSError *error;
    NSDictionary *senderEditProfile=[[NSDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"],@"userId", nil];
    NSData *getBalanceData=[NSJSONSerialization dataWithJSONObject:senderEditProfile options:NSJSONWritingPrettyPrinted error:&error];
    [request addRequestHeader:ContentType value:ContentTypeValue];
    [request appendPostData:getBalanceData];
    NSLog(@"%@",senderEditProfile);
     [request startAsynchronous];
    [request setCompletionBlock:^{
        NSMutableDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
        NSLog(@"Balance root: %@",root);
        if([root[@"isError"] boolValue]==1){
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:root[@"message"]
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
            return ;
        }
        txt_currentBalance.text=[root[@"data"] stringValue];
    
        return_block(TRUE);
    }
     ];
   
    [request setFailedBlock:^{
        NSError *error = [request error];
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:error.localizedDescription
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
    }];
}
-(void)viewWillAppear:(BOOL)animated{
    [self getCurrentBalance:^(BOOL result) {
        if (result) {
           
           }
    }];
    txt_currentBalance.font=[UIFont fontWithName:GZFont size:16];
    txtFund.text=@"";
    txtFund.font=[UIFont fontWithName:GZFont size:16];
    lbl_rechargewith.font=[UIFont fontWithName:GZFont size:16];;
    lbl_currentBal.font=[UIFont fontWithName:GZFont size:16];
    lbl_amount.font=[UIFont fontWithName:GZFont size:16];
    self.environment = PayPalEnvironmentNoNetwork;
    
    [PayPalPaymentViewController setEnvironment:self.environment];
    [PayPalPaymentViewController prepareForPaymentUsingClientId:kPayPalClientId];
}
-(void) buttonWasActivated:(int) buttonTag{
    NSLog(@"%d",buttonTag);
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if(textField==txtFund){
        [txtFund resignFirstResponder];
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    if(newLength>6){
        return NO;
    }
    
    NSCharacterSet *nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    if([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound){
        return ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0) || [string isEqualToString:@""];
    }
    return 1;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [txtFund resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)continueAction:(id)sender {
    
           //self.navigationController.navigationBarHidden=YES;
//NSLog(@"%@",[txtFund.text substringWithRange:nsra]);
    
        if ([txtFund.text length]>0) {
            self.completedPayment = nil;
            
            PayPalPayment *payment = [[PayPalPayment alloc] init];
            payment.amount = [[NSDecimalNumber alloc] initWithString:txtFund.text];
            payment.currencyCode = @"USD";
            payment.shortDescription = @"Pay To GratZeez";
            NSLog(@"%@",[PayPalPaymentViewController libraryVersion]);
            if (!payment.processable) {
                // This particular payment will always be processable. If, for
                // example, the amount was negative or the shortDescription was
                // empty, this payment wouldn't be processable, and you'd want
                // to handle that here.
            }
            
            // Any customer identifier that you have will work here. Do NOT use a device- or
            // hardware-based identifier.
            NSString *customerId = [[NSUserDefaults standardUserDefaults] valueForKey:@"userid"];//@"user-11723";
          //    NSString *customerId = @"user-11723";
            NSLog(@"%@",customerId);
            // Set the environment:
            // - For live charges, use PayPalEnvironmentProduction (default).
            // - To use the PayPal sandbox, use PayPalEnvironmentSandbox.
            // - For testing, use PayPalEnvironmentNoNetwork.
            
            self.environment = PayPalEnvironmentNoNetwork;
            
            [PayPalPaymentViewController setEnvironment:self.environment];
            
            PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithClientId:kPayPalClientId
                                                                                                         receiverEmail:kPayPalReceiverEmail
                                                                                                               payerId:customerId
                                                                                                               payment:payment
                                                                                                              delegate:self];
            paymentViewController.hideCreditCardButton = self.acceptCreditCards;
            paymentViewController.languageOrLocale = @"en";
            
            
            
            //[self.navigationController pushViewController:paymentViewController.visibleViewController animated:NO];
            
            [self  presentViewController:paymentViewController animated:YES completion:nil];
        }
    
    
}

#pragma mark - Proof of payment vlidation
- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
//    NSDictionary *rest_api=[completedPayment.confirmation valueForKey:@"proof_of_payment"];
//    NSLog(@"rest api is===>%@",rest_api);
//    NSLog(@"status%@",[rest_api valueForKey:@"state"]);
    // TODO: Send completedPayment.confirmation to server
    // NSDictionary *payment=[completedPayment.confirmation valueForKey:@"payment"];
    
    // NSMutableDictionary *paypalData=[[NSMutableDictionary alloc]init];
    //  // [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"is-profile-complete"];
    // //[paypalData setValue:[[NSUserDefaults standardUserDefaults]  valueForKey:@"is-profile-complete"] forKey:@"is-profile-complete"];
    // [paypalData setValue:[payment valueForKey:@"amount"] forKey:@"amount"];
    // [paypalData setValue:[payment valueForKey:@"currency_code"] forKey:@"currency_code"];
    //[paypalData setValue:[adaptivePayment valueForKey:@"app_id"] forKey:@"app_id"];
    //[paypalData setValue:[adaptivePayment valueForKey:@"pay_key"] forKey:@"pay_key"];
    //[paypalData setValue:[adaptivePayment valueForKey:@"payment_exec_status"] forKey:@"payment_exec_status"];
    //[paypalData setValue:[adaptivePayment valueForKey:@"timestamp"] forKey:@"timestamp"];
    NSDictionary *paymentProof=[completedPayment.confirmation valueForKey:@"proof_of_payment"];
    NSLog(@"====>%@",paymentProof);
    NSDictionary *adaptivePayment,*rest_api;
    if([[paymentProof valueForKey:@"adaptive_payment"] count]!=0){
    adaptivePayment=[paymentProof valueForKey:@"adaptive_payment"];
   
    }
    else{
        rest_api=[paymentProof valueForKey:@"rest_api"];
    }
    if([[adaptivePayment valueForKey:@"payment_exec_status"] isEqualToString:@"COMPLETED"] || [[rest_api valueForKey:@"state"] isEqualToString:@"approved"]){
        paymentComplete=1;
    }
    NSMutableDictionary *paypalData=[[NSMutableDictionary alloc]init];
    //NSMutableDictionary *pay=[[NSMutableDictionary alloc]init];
    //[pay setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"service-provider"] forKey:@"service_provider"];
    //[pay setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"userid"];
    
//    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeFacebook){
//        
//        [paypalData setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"service-provider"] forKey:@"service_provider"];
//        
//    }
    
    
    [paypalData setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"userid"];
    [paypalData setValue:completedPayment.confirmation forKey:@"paypal_data"];
    NSLog(@"Final Dictionay%@",paypalData);
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLRechargeAccount]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    [request setDelegate:self];
    [request appendPostData:[[NSString stringWithFormat:@"%@",paypalData] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setCompletionBlock:^{
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
        NSLog(@"==> PaymentROOT: %@",root);
        if(paymentComplete){
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:error.localizedDescription
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
    }];
    [request startAsynchronous];
    NSLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment.confirmation);
}

#pragma mark - PayPalPaymentDelegate methods
- (void)payPalPaymentDidComplete:(PayPalPayment *)completedPayment {
    NSLog(@"PayPal Payment Success!");
    self.completedPayment = completedPayment;
    //    self.successView.hidden = NO;
    
    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
//    [self dismissViewControllerAnimated:NO completion:^{
        //      [self RegisterForSender];
        //  [MyAppDelegate.tabBar dismissViewControllerAnimated:NO completion:nil];
    
//        }
//    }];
    // [self.navigationController popToRootViewControllerAnimated:NO ];
    /*    [self.navigationController popViewControllerAnimated:YES];
     //      [self RegisterForSender];
     //  [MyAppDelegate.tabBar dismissViewControllerAnimated:NO completion:nil];
     if(paymentComplete){
     //[self.view setHidden:YES];
     //[self.navigationController setNavigationBarHidden:YES];
     // [self dismissViewControllerAnimated:YES completion:nil];
     } */
    
}
- (void)payPalPaymentDidCancel {
    NSLog(@"PayPal Payment Canceled");
    self.completedPayment = nil;
    //self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:nil];
    // [self.navigationController popToRootViewControllerAnimated:YES];
}



@end
