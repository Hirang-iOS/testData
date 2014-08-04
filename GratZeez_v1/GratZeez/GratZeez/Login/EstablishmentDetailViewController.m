//
//  EstablishmentDetailViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 07/01/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import "EstablishmentDetailViewController.h"

@interface EstablishmentDetailViewController ()

@end

@implementation EstablishmentDetailViewController

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
 
    NSLog(@"called");
       [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)go:(id)sender {
    DemoViewController *dvc1=[[DemoViewController alloc]init];
    [self.navigationController pushViewController:dvc1 animated:YES];
}
@end
