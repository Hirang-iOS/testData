//
//  ChoosenPaymentMethodViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 26/12/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "ChoosenPaymentMethodViewController.h"

@interface ChoosenPaymentMethodViewController ()

@end

@implementation ChoosenPaymentMethodViewController
@synthesize txt_paypal;
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
    self.title=@"Payment Details";
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
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
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (IBAction)continueAction:(id)sender {
//    if([[txt_paypal.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] <=0){
//        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
//                                        type:AJNotificationTypeRed
//                                       title:@"Enter PyaPal detail"
//                             linedBackground:AJLinedBackgroundTypeDisabled
//                                   hideAfter:GZAJNotificationDelay];
//        return;
//    }
//    else{
//    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLServiceProviderInfo]];
//    __unsafe_unretained ASIFormDataRequest *request = _request;
//    [request setDelegate:self];
//    NSDictionary *ServiceProviderPayPalDict = [NSDictionary dictionaryWithObjectsAndKeys:txt_paypal.text, nil];
//    NSLog(@"----> Dict: %@",serviceProviderProfileDict);
//    [request appendPostData:[[NSString stringWithFormat:@"%@",serviceProviderProfileDict] dataUsingEncoding:NSUTF8StringEncoding]];
//    [request setCompletionBlock:^{
//        NSDictionary *root=[NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
//        [self dismissViewControllerAnimated:NO completion:nil];}
//     ];
//    }
//}
@end
