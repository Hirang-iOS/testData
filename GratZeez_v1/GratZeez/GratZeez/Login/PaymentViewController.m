//
//  PaymentViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 15/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "PaymentViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface PaymentViewController ()

@end

@implementation PaymentViewController

@synthesize txtFund,txtFallBelowAmount,txtRechargeAmount,paymentComplete,paymentMethodLbl,lbl_autorecharge,lbl_fund;
@synthesize SwitchFundReplenishment,lblUsername,completeProToolbar,vie_btn;

@synthesize firstName,lastName,contactNumber,email,password,proImage,btn_imagesave,btn_imageUpload;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Complete Profile";
    [self.view setUserInteractionEnabled:YES];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])self.edgesForExtendedLayout = UIRectEdgeNone;
    UIBarButtonItem *btnHelp = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(btnHelpAction:)];
    self.navigationItem.rightBarButtonItem=btnHelp;
    [btnHelp setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    NSArray *option=@[@"Credit card/PayPal",@"Bank Account"];
    paymentRadioGroup=[[RadioButtonView alloc]initWithPayPalFrame:CGRectMake(0, 164, 320, 40) andOptions:option andColumns:2 tag:1];
    paymentRadioGroup.delegate=self;
    [paymentRadioGroup setPayPalSelected:0];
    [self.view addSubview:paymentRadioGroup];
    SwitchFundReplenishment.onTintColor=RGB(109, 72, 46);
    SwitchFundReplenishment.thumbTintColor=RGB(208, 195, 188);
    SwitchFundReplenishment.tintColor=RGB(175, 156, 141);
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_half"]];
    NSMutableAttributedString *paymentString = [[NSMutableAttributedString alloc] initWithString:@"Select Payment Method"];
    [paymentString addAttribute:(NSString*)kCTUnderlineStyleAttributeName
                            value:[NSNumber numberWithInt:kCTUnderlineStyleSingle]
                            range:(NSRange){0,[paymentString length]}];
    [paymentString addAttribute:NSFontAttributeName value:[UIFont fontWithName:GZFont size:18.0] range:(NSRange){0,[paymentString length]}];
    self.paymentMethodLbl.attributedText = paymentString;
    self.paymentMethodLbl.textColor = [UIColor blackColor];
    lbl_autorecharge.textColor=[UIColor blackColor];
    lbl_autorecharge.font=[UIFont fontWithName:GZFont size:15.5];
    lbl_fund.font=[UIFont fontWithName:GZFont size:15.5];
    lbl_fund.textColor=[UIColor blackColor];
    lblDoNotFallBelow.font=[UIFont fontWithName:@"Garamond" size:15.5];
    lblRechargeAmount.font=[UIFont fontWithName:@"Garamond" size:15.5];
    lblUsername.font=[UIFont fontWithName:GZFont size:18.0];
    
    NSString *urlString=[ImageURL stringByAppendingPathComponent:[[NSUserDefaults standardUserDefaults] valueForKey:@"profile-picture"]];
    proImage.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
    proImage.backgroundColor=[UIColor clearColor];
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] != LoginTypeFacebook){
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTapped:)];
        proImage.userInteractionEnabled = YES;
        [proImage addGestureRecognizer:tap];
        btn_imageUpload.hidden=NO;
        btn_imagesave.hidden=YES;
        btn_imagesave.titleLabel.font=[UIFont fontWithName:GZFont size:15];
        btn_imageUpload.titleLabel.font=[UIFont fontWithName:GZFont size:15];
    }
    else{
        btn_imagesave.hidden=YES;
        btn_imageUpload.hidden=YES;
    }
    proImage.layer.borderWidth=0.5;
    
    proImage.layer.cornerRadius=3.0;
    proImage.layer.masksToBounds=YES;
    btn_imageUpload.layer.borderWidth=0.3;
    btn_imageUpload.layer.cornerRadius=3.0;
    btn_imageUpload.layer.masksToBounds=YES;
    btn_imagesave.layer.borderWidth=0.3;
    btn_imagesave.layer.cornerRadius=3.0;
    btn_imagesave.layer.masksToBounds=YES;
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    
    completeProToolbar.frame=CGRectMake(0,524, 320, 44);
    [self.view addSubview:completeProToolbar];
    [completeProToolbar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    [self addLeftMenuButtonWithImage:[UIImage imageNamed:@"menu_icon"]];
    [self addrightMenuButtonWithImage:[UIImage imageNamed:@"help"]];
   
    vie_btn.backgroundColor=[UIColor clearColor];
    
}
-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"%f %f",self.view.frame.size.height,self.view.frame.origin.y);
}
- (void )imageTapped:(UITapGestureRecognizer *) gestureRecognizer
{
    NSLog(@"image tapped");
    UIImagePickerController *imgPicker=[[UIImagePickerController alloc]init];
    imgPicker.delegate=self;
    [imgPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:imgPicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSLog(@"%@",info);
    proImage.image=[info valueForKey:@"UIImagePickerControllerOriginalImage"];
    btn_imagesave.hidden=NO;
    btn_imageUpload.hidden=YES;
   // [uploadImgButton setTitle:@"Save" forState:UIControlStateNormal];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) buttonWasActivated:(int) buttonTag{
    NSLog(@"%d",buttonTag);
}

-(IBAction)btnHelpAction:(id)sender{
    [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                    type:AJNotificationTypeRed
                                   title:@"Coming Soon"
                         linedBackground:AJLinedBackgroundTypeDisabled
                               hideAfter:GZAJNotificationDelay];
    return ;
    HelpViewController *HVC=[[HelpViewController alloc]init];
    UINavigationController *helpNavController=[[UINavigationController alloc]initWithRootViewController:HVC];
    [self presentViewController:helpNavController animated:YES completion:nil];
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [txtFallBelowAmount resignFirstResponder];
    [txtFund resignFirstResponder];
    [txtRechargeAmount resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField==txtFund) {
        [txtFund resignFirstResponder];
      //  [txtFallBelowAmount becomeFirstResponder];
    }
    else if (textField==txtFallBelowAmount) {
        [txtFallBelowAmount resignFirstResponder];
        [txtRechargeAmount becomeFirstResponder];
    }
    else if (textField==txtRechargeAmount) {
        [txtRechargeAmount resignFirstResponder];
    }
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSCharacterSet *nonNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    return ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0) || [string isEqualToString:@""];
}

- (IBAction)btnPaymentAction:(id)sender {
    //self.navigationController.navigationBarHidden=YES;
    NSLog(@"1: %@",txtFund.text);
    NSLog(@"2: %@",txtFallBelowAmount.text);
    NSLog(@"3: %@",txtRechargeAmount.text);
    NSLog(@"4: %d",SwitchFundReplenishment.isOn);
    
    if ([txtFund.text length]>0) {
        self.completedPayment = nil;
        
        PayPalPayment *payment = [[PayPalPayment alloc] init];
        payment.amount = [[NSDecimalNumber alloc] initWithString:txtFund.text];
        payment.currencyCode = @"USD";
        payment.shortDescription = @"Pay To GratZeez";
        
        if (!payment.processable) {
            // This particular payment will always be processable. If, for
            // example, the amount was negative or the shortDescription was
            // empty, this payment wouldn't be processable, and you'd want
            // to handle that here.
        }
        
        // Any customer identifier that you have will work here. Do NOT use a device- or
        // hardware-based identifier.
        NSString *customerId = [[NSUserDefaults standardUserDefaults] valueForKey:@"userid"];
        
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
    else{
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Enter Amount"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
    }
}


#pragma mark - Proof of payment validation
- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
    NSDictionary *paymentProof=[completedPayment.confirmation valueForKey:@"proof_of_payment"];
    NSLog(@"====>%@",paymentProof);
    NSDictionary *adaptivePayment,*rest_api;
    if([[paymentProof valueForKey:@"adaptive_payment"] count]!=0){
        adaptivePayment=[paymentProof valueForKey:@"adaptive_payment"];
        
    }
    else{
        rest_api=[paymentProof valueForKey:@"rest_api"]; //for credit card
    }
    if([[adaptivePayment valueForKey:@"payment_exec_status"] isEqualToString:@"COMPLETED"] || [[rest_api valueForKey:@"state"] isEqualToString:@"approved"]){
        paymentComplete=1;
    }
    else{
        paymentComplete=0;
    }
    NSMutableDictionary *paypalData=[[NSMutableDictionary alloc]init];
    //NSMutableDictionary *pay=[[NSMutableDictionary alloc]init];
    //[pay setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"service-provider"] forKey:@"service_provider"];
    //[pay setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"userid"];
    NSLog(@"%d",[[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProvider"] boolValue]);
    [paypalData setValue:[NSString stringWithFormat:@"%@",[[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProvider"] boolValue]?@"true":@"false"] forKey:@"isServiceProvider"];
    
    [paypalData setValue:[NSString stringWithFormat:@"%@",[[[NSUserDefaults standardUserDefaults] valueForKey:@"isSender"] boolValue]?@"true":@"false"] forKey:@"isSender"];
    
    [paypalData setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"userid"];
    [paypalData setValue:completedPayment.confirmation forKey:@"paypal_data"];
    NSLog(@"Final Dictionay%@",paypalData);
    
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLPaypalSenderData]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    [request setDelegate:self];
    [request appendPostData:[[NSString stringWithFormat:@"%@",paypalData] dataUsingEncoding:NSUTF8StringEncoding]];
    [request addRequestHeader:ContentType value:ContentTypeValue];
    
    [request setCompletionBlock:^{
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
        NSLog(@"==> PaymentROOT: %@",root);
        [self dismissViewControllerAnimated:YES completion:^{
            if(paymentComplete){
                 [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isSenderProfileComplete"];
                UINavigationController *navigationController;
                HistoryViewController *historyVC = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
                navigationController = [[UINavigationController alloc] initWithRootViewController:historyVC ];
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isSenderProfileComplete"];
                //NSLog(@"bool==>,%d",[[[NSUserDefaults standardUserDefaults] valueForKey:@"is-profile-complete"] boolValue]);
                MenuViewController *menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
                [[self sideMenuController ]  changeMenuViewController:menuVC closeMenu:YES];
                [[self sideMenuController ]changeContentViewController:navigationController closeMenu:YES];
               

            }
            else{
                
            }
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeBlue
                                           title:root[@"message"]
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
            
        }];
        
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
    
}
- (void)payPalPaymentDidCancel {
    NSLog(@"PayPal Payment Canceled");
    self.completedPayment = nil;
    //self.successView.hidden = YES;
    [self dismissViewControllerAnimated:YES completion:^{
          paymentComplete=0;
    }];
  
   // [self.navigationController popToRootViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated {
    lblUsername.text =[NSString stringWithFormat:@"%@ %@",[[NSUserDefaults standardUserDefaults] valueForKey:@"first_name"],[[NSUserDefaults standardUserDefaults] valueForKey:@"last_name"]];
    lblDoNotFallBelow.hidden=YES;
    lblRechargeAmount.hidden=YES;
    txtFallBelowAmount.hidden=YES;
    txtRechargeAmount.hidden=YES;
    self.environment = PayPalEnvironmentNoNetwork;
    
    [PayPalPaymentViewController setEnvironment:self.environment];
    [PayPalPaymentViewController prepareForPaymentUsingClientId:kPayPalClientId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)switchAction:(id)sender {
    if(SwitchFundReplenishment.isOn){
        lblDoNotFallBelow.hidden=NO;
        lblRechargeAmount.hidden=NO;
        txtFallBelowAmount.hidden=NO;
        txtRechargeAmount.hidden=NO;
        vie_btn.frame=CGRectMake(vie_btn.frame.origin.x,340,vie_btn.frame.size.width, vie_btn.frame.size.height);
    }
    else{
        lblDoNotFallBelow.hidden=YES;
        lblRechargeAmount.hidden=YES;
        txtFallBelowAmount.hidden=YES;
        txtRechargeAmount.hidden=YES;
         vie_btn.frame=CGRectMake(vie_btn.frame.origin.x,297,vie_btn.frame.size.width, vie_btn.frame.size.height);
    }
}

-(UIImage *) resizeImage:(UIImage *)orginalImage resizeSize:(CGSize)size
{
    CGFloat actualHeight = orginalImage.size.height;
    CGFloat actualWidth = orginalImage.size.width;
    
    float oldRatio = actualWidth/actualHeight;
    float newRatio = size.width/size.height;
    if(oldRatio < newRatio)
    {
        oldRatio = size.height/actualHeight;
        actualWidth = oldRatio * actualWidth;
        actualHeight = size.height;
    }
    else
    {
        oldRatio = size.width/actualWidth;
        actualHeight = oldRatio * actualHeight;
        actualWidth = size.width;
    }
    
    CGRect rect = CGRectMake(0.0,0.0,actualWidth,actualHeight);
    UIGraphicsBeginImageContext(rect.size);
    [orginalImage drawInRect:rect];
    orginalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return orginalImage;
    
}

- (IBAction)saveImageAction:(id)sender {
    ASIFormDataRequest *_request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:URLSaveImage]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    [ASIHTTPRequest setShouldThrottleBandwidthForWWAN:YES];
    [request setUploadProgressDelegate:self];
    // UIImage *compressedImage;
    // compressedImage=[self resizeImage:proImage.image resizeSize:CGSizeMake(170,170)];
    //NSData *data=UIImagePNGRepresentation(compressedImage);
    proImage.image=[self resizeImage:proImage.image resizeSize:CGSizeMake(178,178)];
    NSData *data=UIImageJPEGRepresentation(proImage.image, 1.0);
    [request setPostValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"userid"];
    [request setData:data
        withFileName:@"profile.jpg"
      andContentType:@"image/jpeg"
              forKey:@"file"];
    
    [request setCompletionBlock:^{
        //NSData *responseData = [NSJSONSerialization JSONObjectWithData:[request responseString] options:0 error:nil];
        btn_imagesave.hidden=YES;
        NSDictionary *root=[NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
        NSLog(@"root===>%@",root);
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%@.png",[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"]] forKey:@"profile-picture"];
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error: %@",error.localizedDescription);
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:error.localizedDescription
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
    }];
    [request startAsynchronous];
}

- (IBAction)btnContinueAction:(id)sender {
    NSLog(@"========>");
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLPayLater]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    [request setDelegate:self];
    NSMutableDictionary *payDictionary=[[NSMutableDictionary alloc]init];
  //  [payDictionary setValue:[NSString stringWithFormat:@"%@",[[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProvider"] boolValue]?@"true":@"false"] forKey:@"isServiceProvider"];
    
    //[payDictionary setValue:[NSString stringWithFormat:@"%@",[[[NSUserDefaults standardUserDefaults] valueForKey:@"isSender"] boolValue]?@"true":@"false"] forKey:@"isSender"];
    NSError *error;
    [payDictionary setValue:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"] forKey:@"userId"];
    NSData *payData=[NSJSONSerialization dataWithJSONObject:payDictionary options:NSJSONWritingPrettyPrinted error:&error];
    [request appendPostData:payData];
    [request addRequestHeader:ContentType value:ContentTypeValue];
    [request setCompletionBlock:^{
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
        NSLog(@"PAY LATER ROOT%@",root);
        UINavigationController *navigationController;
        HistoryViewController *historyVC = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
        navigationController = [[UINavigationController alloc] initWithRootViewController:historyVC ];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isSenderProfileComplete"];
        // NSLog(@"bool==>,%d",[[[NSUserDefaults standardUserDefaults] valueForKey:@"is-profile-complete"] boolValue]);
        MenuViewController *menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
        [[self sideMenuController ]  changeMenuViewController:menuVC closeMenu:YES];
        [[self sideMenuController ]changeContentViewController:navigationController closeMenu:YES];
    }
     ];
    [request setFailedBlock:^{
        NSError *error=[request error];
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:error.localizedDescription
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
    }];
    [request startAsynchronous];

    //[[UIApplication sharedApplication] delegate].window
}
- (IBAction)showImagePicker:(id)sender {
    UIImagePickerController *imgPicker=[[UIImagePickerController alloc]init];
    imgPicker.delegate=self;
    [imgPicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:imgPicker animated:YES completion:nil];
}
@end
