//
//  RegistrationViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 15/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "RegistrationViewController.h"

#import "PaymentViewController.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController
@synthesize btnAgreeTerms;
@synthesize btnServiceProvider;
@synthesize gender;
@synthesize txtFirstname;
@synthesize txtLastname;
@synthesize txtContactNumber;
@synthesize txtEmail;
@synthesize txtPassword;
@synthesize txtRePassword;
@synthesize txtUserName;
@synthesize selectedGenderIndex;
@synthesize regNavItem;
@synthesize backbtn;
@synthesize fromBrowser;
@synthesize lbl_create,btnCustomer;
 CGRect frame;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        UIView *addStatusBar = [[UIView alloc] init];
        addStatusBar.frame = CGRectMake(0, 0, 320, 20);
        addStatusBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"status_bar"]]; //change this to match your navigation bar
        [self.view addSubview:addStatusBar];
    }
    textFlag=0;
    textFlag1=0;
    [self.view setUserInteractionEnabled:YES];
    regNavBar.translucent=YES;
    if ([regNavBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)]){
        
        UIImage *navBarImg = [UIImage imageNamed:@"nav_Bar"];
        
        [regNavBar setBackgroundImage:navBarImg forBarMetrics:UIBarMetricsDefault];
        
    }
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
   // if ([self respondsToSelector:@selector(edgesForExtendedLayout)])self.edgesForExtendedLayout = UIRectEdgeNone;
    regNavItem.title=@"Registration";
    UILabel *titleView = (UILabel *)regNavItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont fontWithName:@"Garamond 3 SC" size:20.0];
        titleView.textColor = [UIColor whiteColor];
        regNavItem.titleView=titleView;
    }
    titleView.text=regNavItem.title;
    [titleView sizeToFit];
    genderButton=[[RadioButtonView alloc]initWithFrame:CGRectMake(22, 410, 180, 40) andOptions:@[@"Male",@"Female"] andColumns:2];

    [self.view addSubview:genderButton];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])self.edgesForExtendedLayout = UIRectEdgeNone;
    UIBarButtonItem *btnHelp = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(btnHelpAction:)];
    [btnHelp setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    regNavItem.rightBarButtonItem=btnHelp;

    if(fromBrowser==FALSE){
    backbtn = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    regNavItem.leftBarButtonItem=backbtn;
    [backbtn setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    }
    self.title = @"Registration";
    txtFirstname.font=[UIFont fontWithName:GZFont size:15.0f];
    txtLastname.font=[UIFont fontWithName:GZFont size:15.0f];
    txtUserName.font=[UIFont fontWithName:GZFont size:15.0f];
    txtEmail.font=[UIFont fontWithName:GZFont size:15.0f];
    txtContactNumber.font=[UIFont fontWithName:GZFont size:15.0f];
    txtPassword.font=[UIFont fontWithName:GZFont size:15.0f];
    txtRePassword.font=[UIFont fontWithName:GZFont size:15.0f];
    lbl_agree.font=[UIFont fontWithName:GZFont size:16.0f];
    lbl_create.font=[UIFont fontWithName:GZFont size:16.0f];
    frame=txtEmail.frame;
    lbl_registerAS.font=[UIFont fontWithName:GZFont size:16];
    
 [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title {
    //    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont fontWithName:@"Garamond 3 SC" size:20.0];
        //titleView.textColor = [UIColor colorWithRed:241/255.0 green:90/255.0 blue:41/255.0 alpha:1.0];
        titleView.textColor=[UIColor whiteColor];
        self.navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [txtFirstname resignFirstResponder];
    [txtLastname resignFirstResponder];
    [txtEmail resignFirstResponder];
    [txtUserName resignFirstResponder];
    [txtPassword resignFirstResponder];;
    [txtContactNumber resignFirstResponder];
    [txtRePassword resignFirstResponder];
    [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         //  self.view.frame=CGRectMake(0, 0, 320, 200);
                         self.view.frame=CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height);
                         
                     }
                     completion:^(BOOL finished){
                         if(finished)  {NSLog(@"Finished end !!!!!");}
                     }];
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
    [self presentViewController:helpNavController animated:YES completion:nil];}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAgreeTermsAction:(id)sender {
    if (![btnAgreeTerms isSelected]){
		[btnAgreeTerms setSelected:YES];
	} else {
		[btnAgreeTerms setSelected:NO];
	}
}
- (IBAction)btnServiceProviderAction:(id)sender {
    if (![btnServiceProvider isSelected]){
		[btnServiceProvider setSelected:YES];
	} else {
		[btnServiceProvider setSelected:NO];
	}
}
-(void)chagneTextFieldStyle:(UITextField *)textField{
    textField.layer.borderColor=[[UIColor redColor] CGColor];
    textField.layer.borderWidth=1;
    textField.layer.masksToBounds=YES;
    textField.layer.cornerRadius=4.7;
//    textField.layer.shadowOpacity = 0.2;
//    textField.layer.shadowRadius = 0.0;
//    textField.layer.shadowColor = [UIColor redColor].CGColor;
//    textField.layer.shadowOffset = CGSizeMake(1.0, -0.5);
}
- (IBAction)btnContinueAction:(id)sender {
    if(genderButton.genderButtonIndex==1){
        gender=@"Male";
    }
    else if(genderButton.genderButtonIndex==2){
        gender=@"Female";
    }
    NSLog(@"Gender reg %d gender string %@",genderButton.genderButtonIndex,gender);
    if([txtFirstname.text length]<=0 ||
       [txtLastname.text length]<=0 ||
       [txtEmail.text length] <=0 ||
       [txtUserName.text length]<=0 ||
       [txtPassword.text length] <=0 ||
       [txtRePassword.text length] <= 0)  {
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"All fields with * are mandatory"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        if([txtFirstname.text length]==0){
            [self chagneTextFieldStyle:txtFirstname];
        }
        if([txtLastname.text length]==0){
            [self chagneTextFieldStyle:txtLastname];
        }
        if([txtEmail.text length]==0){
            [self chagneTextFieldStyle:txtEmail];
        }
        if([txtUserName.text length]==0){
            [self chagneTextFieldStyle:txtUserName];
        }
        if([txtPassword.text length]==0){
             [self chagneTextFieldStyle:txtPassword];
        }
        if([txtRePassword.text length]==0){
             [self chagneTextFieldStyle:txtRePassword];
        }
        
    }
    else if(![self emailvalidity:txtEmail.text]) {
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Please enter valid email address"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        [self chagneTextFieldStyle:txtEmail];
       
        
    }
    else if([txtPassword.text length]< 6 || [txtPassword.text length]>=20) {
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Password must be between 6 to 20 characters"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
         [self chagneTextFieldStyle:txtPassword];
         [self chagneTextFieldStyle:txtRePassword];
        
    }
	else if(![txtPassword.text isEqualToString:txtRePassword.text]) {
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Please reconfirm password"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        [self chagneTextFieldStyle:txtPassword];
        [self chagneTextFieldStyle:txtRePassword];
        
    }
    else if (![self isFoundSpecialCharacter:txtPassword.text]) {
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Password must contain one special character."
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        [self chagneTextFieldStyle:txtPassword];
    }
    else if (!btnAgreeTerms.isSelected) {
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"You must agree to our Terms and Conditions"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
    }
    else if(genderButton.genderButtonIndex==0){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Please Select Gender"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
    }
    else if (!btnCustomer.isSelected && !btnServiceProvider.isSelected){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Please Select User Type"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
    }
    else {
        NSLog(@"Parameter Done");
        
        ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLRegistration]];
        __unsafe_unretained ASIFormDataRequest *request = _request;
        [request setDelegate:self];
        NSArray *objects;
        NSArray *keys;
        if(fromBrowser==TRUE){
//            objects = [NSArray arrayWithObjects:
//                                txtFirstname.text,
//                                txtLastname.text,
//                                txtUserName.text,
//                                txtContactNumber.text,
//                                txtEmail.text,
//                                gender,
//                                [MyAppDelegate md5HexDigest:txtPassword.text],
//                                @"YES",
//                                @"YES",
//                                nil];
            objects = [NSArray arrayWithObjects:
                       txtFirstname.text,
                       txtLastname.text,
                       txtUserName.text,
                       txtContactNumber.text,
                       txtEmail.text,
                       gender,
                       txtPassword.text,
                       @"YES",
                       @"YES",
                       nil];

            keys = [NSArray arrayWithObjects:
                             @"first_name",
                             @"last_name",
                             @"user_name",
                             @"contact_number",
                             @"email",
                             @"gender",
                             @"password",
                             @"service_provider",
                            @"invitedUser",
                             nil];
        }
        else{
        objects = [NSArray arrayWithObjects:
                            txtFirstname.text,
                            txtLastname.text,
                            txtUserName.text,
                            txtContactNumber.text,
                            txtEmail.text,
                            gender,
                            txtPassword.text,
                            (btnServiceProvider.isSelected)?@"true":@"false",
                            (btnCustomer.isSelected)?@"true":@"false",
                            nil];
          keys = [NSArray arrayWithObjects:
                             @"firstName",
                             @"lastName",
                             @"userName",
                             @"contactNumber",
                             @"email",
                             @"gender",
                             @"password",
                             @"isServiceProvider",
                             @"isSender",
                             nil];
        }
        NSError *error;
        NSDictionary *registrationDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        NSLog(@"reg dic %@",registrationDictionary);
        NSData *regData=[NSJSONSerialization dataWithJSONObject:registrationDictionary options:NSJSONWritingPrettyPrinted error:&error];
        BOOL f=            [NSJSONSerialization isValidJSONObject:registrationDictionary];
        NSLog(@"error===>,%@",error);
        NSLog(@"valid===>%d",f);

        [request addRequestHeader:ContentType value:ContentTypeValue];
        [request appendPostData:regData];
      //  [request appendPostData:[NSString stringWithFormat:@"%@",registrationDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
        [request setCompletionBlock:^{
            NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
            NSLog(@"==> ROOT: %@",root);
            if ([root objectForKey:@"isError"] != [NSNull null]) {
                if (![[root objectForKey:@"isError"] boolValue]) {
                   
                    [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                    type:AJNotificationTypeBlue
                                                   title:[root objectForKey:@"message"]
                                         linedBackground:AJLinedBackgroundTypeDisabled
                                               hideAfter:GZAJNotificationDelay];
         
                    [self dismissViewControllerAnimated:NO completion:^{
                      //  [MyAppDelegate LoginRequired:nil];
                    }];

                }
                else {
                    [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                                    type:AJNotificationTypeRed
                                                   title:[root objectForKey:@"message"]
                                         linedBackground:AJLinedBackgroundTypeDisabled
                                               hideAfter:GZAJNotificationDelay];
                    if ([root[@"message"] isEqualToString:@"User Name already exists."]) {
                        [self chagneTextFieldStyle:txtUserName];
                    }
                    if([root[@"message"] isEqualToString:@"Email Address already exists."]){
                        [self chagneTextFieldStyle:txtEmail];
                    }
                }
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

        
   
    
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {

    if(textField==txtContactNumber){
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if(newLength>12){
            return NO;
        }
        
        NSCharacterSet *nonNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        if([string rangeOfCharacterFromSet:nonNumberSet].location != NSNotFound){
            return ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0) || [string isEqualToString:@""];
        }
        
    }
    
    if (textField==txtFirstname) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 15) ? NO : YES;
    }
    if (textField==txtLastname) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 15) ? NO : YES;
    }
    if (textField==txtLastname) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 15) ? NO : YES;
    }
    if (textField==txtUserName) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 15) ? NO : YES;
    }
    if (textField==txtEmail) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 50) ? NO : YES;
    }
    if (textField==txtPassword) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 20) ? NO : YES;
    }
    if (textField==txtRePassword) {
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return (newLength > 20) ? NO : YES;
    }
    else
        return 1;
    
}

- (BOOL)emailvalidity:(NSString *)emailString {
	
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	
	return [emailTest evaluateWithObject:emailString];
}
- (BOOL)isFoundSpecialCharacter:(NSString*)stringToValidate {
    NSCharacterSet * set = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ0123456789"] invertedSet];
    if ([stringToValidate rangeOfCharacterFromSet:set].location != NSNotFound) {
        //string contains illegal characters
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField==txtFirstname) {
        [txtFirstname resignFirstResponder];
        [txtLastname becomeFirstResponder];
    }
    else if (textField==txtLastname) {
        [txtLastname resignFirstResponder];
        [txtEmail becomeFirstResponder];
    }
    else if (textField==txtEmail){
        [txtEmail resignFirstResponder];
        [txtContactNumber becomeFirstResponder];
    }
    else if (textField==txtContactNumber) {
        [txtContactNumber resignFirstResponder];
        [txtUserName becomeFirstResponder];
    }
    else if (textField==txtUserName) {
        [txtUserName resignFirstResponder];
        [txtPassword becomeFirstResponder];
    }
    else if (textField==txtPassword) {
        [txtPassword resignFirstResponder];
        [txtRePassword becomeFirstResponder];
    }
    else if (textField==txtRePassword) {
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             //  self.view.frame=CGRectMake(0, 0, 320, 200);
                             self.view.frame=CGRectMake(0, 0,self.view.frame.size.width,self.view.frame.size.height);
                             
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];
        [txtRePassword resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField==txtFirstname){
        txtFirstname.layer.borderWidth=0;
        NSLog(@"%f %f",self.view.frame.origin.y,self.view.frame.size.height);
    }
    else if(textField==txtLastname){
        txtLastname.layer.borderWidth=0;
       
    }
    else if(textField==txtEmail){
        txtEmail.layer.borderWidth=0;
     
    }
    else if(textField==txtUserName){
        txtUserName.layer.borderWidth=0;
       
    }
    else if(textField==txtPassword){
        txtPassword.layer.borderWidth=0;
       
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             //  self.view.frame=CGRectMake(0, 0, 320, 200);
                             self.view.frame=CGRectMake(0, -120,self.view.frame.size.width,self.view.frame.size.height);
                             
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];
       
    }
    else if(textField==txtRePassword){
        txtRePassword.layer.borderWidth=0;
        [UIView animateWithDuration:0.25 delay:0.0 options: UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             //  self.view.frame=CGRectMake(0, 0, 320, 200);
                             self.view.frame=CGRectMake(0, -120,self.view.frame.size.width,self.view.frame.size.height);
                             
                         }
                         completion:^(BOOL finished){
                             if(finished)  {NSLog(@"Finished end !!!!!");}
                         }];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    center=self.view.center;
   }

-(void)viewDidDisappear:(BOOL)animated{
    fromBrowser=FALSE;
    lbl_create.hidden=FALSE;
    btnServiceProvider.hidden=FALSE;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
//    if(textField==txtRePassword){
//        //        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{CGRect frame;
//        //            frame=self.view.frame;
//        //            frame.origin.y=frame.origin.y+120;
//        //            self.view.frame=frame;
//        //        } completion:^(BOOL finished){
//        //            if(finished){
//        //                NSLog(@"finished");
//        //                textFlag1=0;
//        //            }
//        //        }];
//        self.view.center=CGPointMake(center.x, center.y);
//        textFlag=0;
//    }
}




- (IBAction)backButtonAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)btnCustomerAction:(id)sender {
    if (![btnCustomer isSelected]){
		[btnCustomer setSelected:YES];
	} else {
		[btnCustomer setSelected:NO];
	}
}
@end
