//
//  Demo1ViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 07/01/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import "Demo1ViewController.h"

@interface Demo1ViewController ()

@end

@implementation Demo1ViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)back:(id)sender {
    ServiceProviderEditProfileViewController *svc=[[ServiceProviderEditProfileViewController alloc]init];
    ;
}
@end
