//
//  InvoiceViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 13/02/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import "InvoiceViewController.h"

@interface InvoiceViewController ()

@end

@implementation InvoiceViewController
@synthesize invoiceToolbar,lbl_amount,lbl_amountPaid,lbl_date,lbl_gratuityGiven,btn_receiver,lbl_Ondate,receiverName,amountPaid,lbl_gratuity,lbl_gratuityAmount,gratuity,lbl_fromaccount;
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
    self.title=@"Invoice";
    self.view.backgroundColor=RGB(210, 200, 191);
    invoiceToolbar.frame=CGRectMake(0, 524, 320, 44);
    [self.view addSubview:invoiceToolbar];
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 21)];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *btnitem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    invoiceToolbar.items=@[btnitem];
    [invoiceToolbar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    [self addLeftMenuButtonWithImage:[UIImage imageNamed:@"menu_icon"]];
    [self addrightMenuButtonWithImage:[UIImage imageNamed:@"help"]];
    
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:rightRecognizer];
    lbl_gratuityGiven.font=[UIFont fontWithName:GZFont size:16];
    lbl_amountPaid.font=[UIFont fontWithName:GZFont size:16];
    lbl_amountPaid.numberOfLines=0;
    lbl_amountPaid.lineBreakMode=NSLineBreakByWordWrapping;
    lbl_amountPaid.textAlignment=NSTextAlignmentLeft;
    lbl_Ondate.font=[UIFont fontWithName:GZFont size:16];
    lbl_amount.font=[UIFont fontWithName:GZFont size:16];
    lbl_date.font=[UIFont fontWithName:GZFont size:16];
    lbl_gratuityAmount.font=[UIFont fontWithName:GZFont size:16];
    lbl_gratuity.font=[UIFont fontWithName:GZFont size:16];
    lbl_fromaccount.font=[UIFont fontWithName:GZFont size:15];
   // btn_receiver.titleLabel.font=[UIFont fontWithName:GZFont size:16];
       // [btn_receiver.titleLabel sizeToFit];
   // btn_receiver.titleLabel.frame=CGRectMake(0, btn_receiver.titleLabel.frame.origin.y, size.width, btn_receiver.titleLabel.frame.size.height);
    //[btn_receiver setTitle:receiverName forState:UIControlStateNormal];
    //btn_receiver.titleLabel.text=receiverName;
    lbl_amount.text=amountPaid;
   // NSDate *d=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM-dd-yyyy h:m:s"];
    lbl_date.text=[NSString stringWithFormat:@"%@",[dateFormatter stringFromDate:[NSDate date]]];
    lbl_gratuity.text=gratuity;
    NSMutableAttributedString *locateManually = [[NSMutableAttributedString alloc] initWithString:receiverName];
    [locateManually addAttribute:NSForegroundColorAttributeName  value:[UIColor blueColor] range:(NSRange){0,[locateManually length]}];
    [locateManually addAttribute:(NSString*)kCTUnderlineStyleAttributeName
                           value:[NSNumber numberWithInt:NSUnderlineStyleSingle]
                           range:(NSRange){0,[locateManually length]}];
    [locateManually addAttribute:NSFontAttributeName value:[UIFont fontWithName:GZFont size:16.0f] range:(NSRange){0,[locateManually length]}];
    [btn_receiver setAttributedTitle:locateManually forState:UIControlStateNormal];
    // Do any additional setup after loading the view from its nib.
}
-(void)backAction:(id)sender{
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
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _img;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)receiverProfileAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)okAction:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
