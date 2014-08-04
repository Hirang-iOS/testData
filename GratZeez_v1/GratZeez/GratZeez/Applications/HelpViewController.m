//
//  HelpViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 18/11/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end

@implementation HelpViewController

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
   self.title=@"Help";
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction:)];
    UITabBarController *helpTabbar=[[UITabBarController alloc]init];
    ContactUsViewController *contactUsVC=[[ContactUsViewController alloc]init];
    helpTabbar.viewControllers=@[contactUsVC];
    lblHelp.numberOfLines=0;
    lblHelp.lineBreakMode=NSLineBreakByWordWrapping;
    lblHelp.textAlignment=NSTextAlignmentLeft;
    // Do any additional setup after loading the view from its nib.
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


-(IBAction)backButtonAction:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
