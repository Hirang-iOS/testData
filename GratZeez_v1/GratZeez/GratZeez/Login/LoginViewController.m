//
//  LoginViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 14/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "LoginViewController.h"

#import "RegistrationViewController.h"
#import "ForgetPasswordViewController.h"
#import "ForgetPasswordController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize txtUsername,SelectionView,lbl_customer,lbl_serviceProvider;
@synthesize txtPassword,lbl_facebook,btnCustomer,btnServiceProvider,lbl_register;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if(MyAppDelegate.isiPhone5){
        self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background5"]];
    }
    else{
        self = [super initWithNibName:@"LoginViewController4s" bundle:[NSBundle mainBundle]];
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    }
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setUserInteractionEnabled:YES];
    self.title = @"GratZeez";
    lbl_facebook.font=[UIFont fontWithName:GZFont size:12.0f];
    txtPassword.font=[UIFont fontWithName:GZFont size:15.0f];
    txtUsername.font=[UIFont fontWithName:GZFont size:15.0f];
     mainViewPoint=self.view.center;

    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])self.edgesForExtendedLayout = UIRectEdgeNone;
}
-(void)viewWillAppear:(BOOL)animated{
     NSLog(@"Session===>%@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
self.navigationController.navigationBar.hidden=YES;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [txtPassword resignFirstResponder];
    [txtUsername resignFirstResponder];
}


- (void)setTitle:(NSString *)title {
    //    [super setTitle:title];
    UILabel *titleView = (UILabel *)self.navigationItem.titleView;
    if (!titleView) {
        titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        titleView.backgroundColor = [UIColor clearColor];
        titleView.font = [UIFont fontWithName:GZFont size:16.0];
        titleView.textColor = [UIColor colorWithRed:241/255.0 green:90/255.0 blue:41/255.0 alpha:1.0];
        self.navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}

- (IBAction)ForgotPasswordAction:(id)sender {

    ForgetPasswordController *FPVc=[[ForgetPasswordController alloc]initWithNibName:@"ForgetPasswordController" bundle:nil];
    UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:FPVc];
    [self presentViewController:navController animated:YES completion:nil];
}
- (IBAction)RegisterAction:(id)sender {

    RegistrationViewController *RegistrationVC=[[RegistrationViewController alloc] initWithNibName:@"RegistrationViewController" bundle:nil];
    [self presentViewController:RegistrationVC animated:YES completion:nil];
}
- (IBAction)LoginAction:(id)sender {
    NSLog(@"LoginAction");
    
          if ([txtUsername.text length]>0 && [txtPassword.text length]>0) {
        
        [[NSUserDefaults standardUserDefaults] setInteger:LoginTypeGZNative forKey:@"UserLogedInType"];
        
       // NSArray *objects = [NSArray arrayWithObjects:txtUsername.text,[MyAppDelegate md5HexDigest:txtPassword.text],nil];
        NSArray *objects = [NSArray arrayWithObjects:txtUsername.text,txtPassword.text,nil];
        
        NSArray *keys = [NSArray arrayWithObjects:@"username", @"password", nil];
        NSDictionary *loginDictionary = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        [MyAppDelegate AutoSignIn:loginDictionary completionBlock:^(BOOL result) {
            if (result) {
               MyAppDelegate.isUserSessionStart=YES;
                if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSender"] boolValue]==1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProvider"] boolValue]==1) {
                    
                UIAlertView *alert1 = [[UIAlertView alloc] initWithTitle:@"Login As:"
                                                                message:nil
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"ServiceProvider",@"Customer", nil];
                alert1.tag=2;
                [alert1 show];
                    
                }
                else if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSender"] boolValue]==1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProvider"] boolValue]==0){
                    [self LoginRedirectionForSender];
                }
              else if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSender"] boolValue]==0 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProvider"] boolValue]==1){
                  [self LoginRedirectionForServiceProvider];
              }
                }
            }
        ];
        
          }
    else{
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Enter Login details"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
    }
}


- (IBAction)FBLoginAction:(id)sender {
    
    [MyAppDelegate openSessionWithAllowLoginUI:YES completionBlock:^(BOOL result) {
        NSLog(@"Connecte via Joint Page Thank you");
        if (result) {
            NSLog(@"%@  %d ", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation],[[[NSUserDefaults standardUserDefaults] valueForKey:@"isSender"]boolValue]);
            if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSender"]boolValue]==0 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProvider"] boolValue]==0){
                lbl_register.font=[UIFont fontWithName:GZFont size:16];
                lbl_serviceProvider.font=[UIFont fontWithName:GZFont size:14];
                lbl_customer.font=[UIFont fontWithName:GZFont size:14];
            SelectionView.center=self.view.center;
                SelectionView.layer.borderColor=[[UIColor blackColor] CGColor];
                SelectionView.layer.borderWidth=1.0;
                SelectionView.layer.cornerRadius=5;
                SelectionView.layer.masksToBounds=YES;
                [UIView animateWithDuration:0.4 animations:^{
                    SelectionView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
                } completion:^(BOOL finished) {
                    SelectionView.center=self.view.center;
                    
                    [UIView animateWithDuration:0.4 animations:^{
                        SelectionView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.95,0.95);
                    } completion:^(BOOL finished) {
                       // self.view.userInteractionEnabled=NO;
                    }];
                }];
                [self.view addSubview:SelectionView];
                
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"User Type"
//                                                                message:@"Are You Want To register As a Service Provider?"
//                                                               delegate:self
//                                                      cancelButtonTitle:nil
//                                                      otherButtonTitles:@"Yes",@"No", nil];
//                alert.tag=1;
//                [alert show];
                
            }
            else{
                if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSender"]boolValue]==1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProvider"] boolValue]==0) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:Sender forKey:@"LoginAs"];
                     [[NSUserDefaults standardUserDefaults] synchronize];
                    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSenderProfileComplete"] boolValue]==0){
                        [MyAppDelegate CompleteProfile];
                    }
                    else{
                   
                    HistoryViewController *historyVC = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
                    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:historyVC ];
                    
                    MenuViewController *menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
                    [[self sideMenuController] disable];
                    [[self sideMenuController] changeMenuViewController:menuVC closeMenu:YES];
                    [[self sideMenuController] changeContentViewController:navigationController closeMenu:YES];
                    }
                }
                else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSender"]boolValue]==0 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProvider"] boolValue]==1)
                {
                    [[NSUserDefaults standardUserDefaults] setObject:ServiceProvider forKey:@"LoginAs"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProviderCompleteProfile"] boolValue]==0){
                        [MyAppDelegate CompleteProfile];
                    }
                    else{
                    GratuityViewController *gratuityVC=[[GratuityViewController alloc] initWithNibName:@"GratuityViewController" bundle:nil];
                    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:gratuityVC ];
                    
                    MenuViewController *menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
                    [[self sideMenuController] disable];
                    [[self sideMenuController]  changeMenuViewController:menuVC closeMenu:YES];
                    [[self sideMenuController]  changeContentViewController:navigationController closeMenu:YES];
                    }
                }
                else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSender"] boolValue]==1 && [[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProvider"] boolValue]==1){
                    UIAlertView *alert12 = [[UIAlertView alloc] initWithTitle:@"Login As:"
                                                                     message:nil
                                                                    delegate:self
                                                           cancelButtonTitle:nil
                                                           otherButtonTitles:@"ServiceProvider",@"Customer", nil];
                    alert12.tag=2;
                    [alert12 show];
                }
            }
        }
        
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView.tag==1){
        if(buttonIndex==0){
            NSLog(@"service provider");
            
            [[NSUserDefaults standardUserDefaults] setObject:@"true" forKey:@"isServiceProvider"];
            [[NSUserDefaults standardUserDefaults] setObject:ServiceProvider forKey:@"LoginAs"];
            [[NSUserDefaults standardUserDefaults] setObject:@"false" forKey:@"isSender"];
            if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProviderProfileComplete"]  boolValue]==0){
                [MyAppDelegate CompleteProfile];
            }        }
        //for no
        if(buttonIndex==1)
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"false" forKey:@"isServiceProvider"];
            [[NSUserDefaults standardUserDefaults] setObject:Sender forKey:@"LoginAs"];
            [[NSUserDefaults standardUserDefaults] setObject:@"true" forKey:@"isSender"];
            if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSenderProfileComplete"]  boolValue]==0){
                [MyAppDelegate CompleteProfile];
            }
        }
    }
 
    //login user type alert
    
    if(alertView.tag==2){
        NSLog(@"index:%d",buttonIndex);
        if(buttonIndex==0){
            [self LoginRedirectionForServiceProvider];
        }
        if(buttonIndex==1){
            [self LoginRedirectionForSender];
            }
        }

}

-(void)LoginRedirectionForSender{
    [[NSUserDefaults standardUserDefaults] setObject:Sender forKey:@"LoginAs"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isSenderProfileComplete"] boolValue]==0){
        [MyAppDelegate CompleteProfile];
    }
    else{
        HistoryViewController *historyVC = [[HistoryViewController alloc] initWithNibName:@"HistoryViewController" bundle:nil];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:historyVC ];
        MenuViewController *menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
        [[self sideMenuController] disable];
        [[self sideMenuController ] changeMenuViewController:menuVC closeMenu:YES];
        [[self sideMenuController ] changeContentViewController:navigationController closeMenu:YES];
    }
}
-(void)LoginRedirectionForServiceProvider{
    [[NSUserDefaults standardUserDefaults] setObject:ServiceProvider forKey:@"LoginAs"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"isServiceProviderProfileComplete"] boolValue]==0){
        [MyAppDelegate CompleteProfile];
    }
    else{
        GratuityViewController *gratuityVC=[[GratuityViewController alloc] initWithNibName:@"GratuityViewController" bundle:nil];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:gratuityVC ];
        MenuViewController *menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
        [[self sideMenuController] disable];
        [[self sideMenuController ] changeMenuViewController:menuVC closeMenu:YES];
        [[self sideMenuController ] changeContentViewController:navigationController closeMenu:YES];
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField==txtUsername) {
        [txtUsername resignFirstResponder];
        [txtPassword becomeFirstResponder];
    } else if (textField==txtPassword) {
        [txtPassword resignFirstResponder];
        if ([txtUsername.text length]>0 && [txtPassword.text length]>0) {
            [self LoginAction:nil];
        }
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)SelectionAction:(id)sender {
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLUpdateFaceBookUserType]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    [request setDelegate:self];
    NSArray *object=[[NSArray alloc]initWithObjects:(btnCustomer.isSelected?@"true":@"false"),(btnServiceProvider.isSelected?@"true":@"false"),[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"],nil];
    NSArray *key=[[NSArray alloc]initWithObjects:@"isSender",@"isServiceProvider",@"userId", nil];
    NSMutableDictionary *fbUserType=[[NSMutableDictionary alloc]initWithObjects:object forKeys:key];
    NSLog(@"dict%@",fbUserType);
    NSError *error;
    NSData *fbData=[NSJSONSerialization dataWithJSONObject:fbUserType options:NSJSONWritingPrettyPrinted error:&error];
    [request appendPostData:fbData];
    NSLog(@"%@",fbData);
    [request addRequestHeader:ContentType value:ContentTypeValue];
    [request setCompletionBlock:^{
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
        if([root[@"isError"] boolValue]==1){
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:@"Error"
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
        }
        else{
            if(btnCustomer.isSelected && !btnServiceProvider.isSelected){
                [[NSUserDefaults standardUserDefaults] setObject:Sender forKey:@"LoginAs"];
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isSender"];
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isServiceProvider"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                PaymentViewController *paymentVC=[[PaymentViewController alloc]initWithNibName:@"PaymentViewController" bundle:nil];
                UINavigationController *navController=[[UINavigationController alloc]initWithRootViewController:paymentVC];
                MenuViewController *menuVC = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
                [[self sideMenuController] disable];
                [[self sideMenuController]  changeMenuViewController:menuVC closeMenu:YES];
                [[self sideMenuController] changeContentViewController:navController closeMenu:YES];
            }
            else if (btnServiceProvider.isSelected && !btnCustomer.isSelected){
                [[NSUserDefaults standardUserDefaults] setObject:ServiceProvider forKey:@"LoginAs"];
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isServiceProvider"];
                [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isSender"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self LoginRedirectionForServiceProvider];
                
            }
            else if (btnCustomer.isSelected && btnServiceProvider.isSelected){
                [[NSUserDefaults standardUserDefaults] setObject:Sender forKey:@"LoginAs"];
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isServiceProvider"];
                [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isSender"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self LoginRedirectionForSender];
            }
        }
    }];
    [request setFailedBlock:^{
        NSError *error=[request error];
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:error.localizedDescription
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
    }];
    [request startAsynchronous];
}
- (IBAction)btnServiceProviderAction:(id)sender {
    if (![btnServiceProvider isSelected]){
		[btnServiceProvider setSelected:YES];
	} else {
		[btnServiceProvider setSelected:NO];
	}
}
- (IBAction)btnCustomerAction:(id)sender {
    if (![btnCustomer isSelected]){
		[btnCustomer setSelected:YES];
	} else {
		[btnCustomer setSelected:NO];
	}
}
@end

