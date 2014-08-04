//
//  CharityDetailViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 02/12/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "CharityDetailViewController.h"
#import "SideMenuController.h"
@interface CharityDetailViewController ()

@end

@implementation CharityDetailViewController
@synthesize txtCharityEmail,txtCharityName,charityToolBar;
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
    self.title=@"Charity Details";
    NSLog(@"called");
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])self.edgesForExtendedLayout = UIRectEdgeNone;
    NSArray *ver = [[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."];
    NSLog(@"ver is%@",ver);
    if ([[ver objectAtIndex:0] intValue] >= 7) {
        self.navigationController.navigationBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"top_bar"]];
        self.navigationController.navigationBar.translucent = NO;
    } else {
        self.navigationController.navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"top_bar"]];
        
    }
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_half"]];
  //   NSDictionary* textAttributes = [NSDictionary dictionaryWithObject: [UIColor whiteColor] forKey: NSForegroundColorAttributeName];
   //  [btnHelp setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
  /*  txtCharityEmail.layer.borderWidth=1.0;
    txtCharityEmail.layer.borderColor=[[UIColor grayColor]CGColor];
    [txtCharityEmail.layer setCornerRadius:4.0];
    [txtCharityEmail.layer setMasksToBounds:NO]; */
    //[self.navigationItem.backBarButtonItem setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    txtCharityEmail.font=[UIFont fontWithName:GZFont size:15.0f];
    txtCharityName.font=[UIFont fontWithName:GZFont size:15.0f];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    charityToolBar.frame=CGRectMake(0, 524, 320, 44);
    [self.view addSubview:charityToolBar];
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 21)];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *btnitem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    charityToolBar.items=@[btnitem];
    [charityToolBar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
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
-(void)chagneTextFieldStyle:(UITextField *)textField{
    textField.layer.borderColor=[[UIColor redColor] CGColor];
    textField.layer.borderWidth=1;
    textField.layer.masksToBounds=YES;
    textField.layer.cornerRadius=4.7;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if(textField==txtCharityName){
        txtCharityName.layer.borderWidth=0;
    }
    if(textField==txtCharityEmail){
        txtCharityEmail.layer.borderWidth=0;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField==txtCharityName){
        [txtCharityName resignFirstResponder];
        [txtCharityEmail becomeFirstResponder];
    }
    if(textField==txtCharityEmail){
        [txtCharityEmail resignFirstResponder];
    }
    return 1;
}
- (IBAction)charityContinueAction:(id)sender {
    if([[txtCharityName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]<=0 || [[txtCharityEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]length]<=0 ){
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Enter All fields."
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        if([[txtCharityName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0){
            [self chagneTextFieldStyle:txtCharityName];
        }
        if([[txtCharityEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0){
            [self chagneTextFieldStyle:txtCharityEmail];
        }
        if([[txtCharityName.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]<=0 && [[txtCharityEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]length]<=0 ){
        [self chagneTextFieldStyle:txtCharityEmail];
           [self chagneTextFieldStyle:txtCharityName];
        }
        
    }
    else if(![self emailvalidity:txtCharityEmail.text]) {
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Please enter valid email address"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
         [self chagneTextFieldStyle:txtCharityEmail];
    }
    else{
        [_delegate charityName:txtCharityName.text mail:txtCharityEmail.text];
        [self.navigationController popViewControllerAnimated:YES];
        
//    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLAddCharity]];
//    __unsafe_unretained ASIFormDataRequest *request = _request;
//    [request setDelegate:self];
//    NSMutableArray *objects=[[NSMutableArray alloc]initWithObjects:txtCharityName.text,txtCharityEmail.text , nil];
//    NSMutableArray *keys=[[NSMutableArray alloc]initWithObjects:@"charity_name",@"charity_mail", nil];
//        NSDictionary *charityDictionary=[[NSDictionary alloc]initWithObjects:objects forKeys:keys];
//        NSLog(@"%@charitydict",charityDictionary);
//        [request appendPostData:[[NSString stringWithFormat:@"%@",charityDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
//        [request setCompletionBlock:^{
//            NSDictionary *root=[NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
//            [_delegate charityName:txtCharityName.text];
//            [self.navigationController popToRootViewControllerAnimated:YES];
//            NSLog(@"charity root..%@",root);
//        }];
//        [request setFailedBlock:^{
//            NSError *error = [request error];
//            NSLog(@"Error: %@",error.localizedDescription);
//            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
//                                            type:AJNotificationTypeRed
//                                           title:error.localizedDescription
//                                 linedBackground:AJLinedBackgroundTypeDisabled
//                                       hideAfter:GZAJNotificationDelay];
//        }];
//       [request startAsynchronous];
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [txtCharityEmail resignFirstResponder];
    [txtCharityName resignFirstResponder];
}
- (BOOL)emailvalidity:(NSString *)emailString {
	
	NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	
	return [emailTest evaluateWithObject:emailString];
}

@end
