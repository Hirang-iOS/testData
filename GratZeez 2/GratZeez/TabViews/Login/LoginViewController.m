//
//  LoginViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 14/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"GratZeez";
    
    [self updateView];

    
    
//    if (!MyAppDelegate.session.isOpen) {
//        MyAppDelegate.session = [[FBSession alloc] init];
//        if (MyAppDelegate.session.state == FBSessionStateCreatedTokenLoaded) {
//            [MyAppDelegate.session openWithCompletionHandler:^(FBSession *session,
//                                                             FBSessionState status,
//                                                             NSError *error) {
//                [self updateView];
//            }];
//        }
//    }

}


- (void)updateView {
    if (MyAppDelegate.session.isOpen) {
        [self.btnFBConnect setTitle:@"Log out Facebook" forState:UIControlStateNormal];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        
        NSLog(@"https://graph.facebook.com/me/friends?access_token=%@", MyAppDelegate.session.accessTokenData.accessToken);
        
//        [self.textNoteOrLink setText:[NSString stringWithFormat:@"https://graph.facebook.com/me/friends?access_token=%@", MyAppDelegate.session.accessTokenData.accessToken]];
    } else {
        [self.btnFBConnect setTitle:@"Log in Facebook" forState:UIControlStateNormal];
//        [self.textNoteOrLink setText:@"Login to create a link to fetch account data"];
    }
}



- (IBAction)RegisterAction:(id)sender {
}
- (IBAction)LoginAction:(id)sender {
}
- (IBAction)FBLoginAction:(id)sender {
    
    [MyAppDelegate openSessionWithAllowLoginUI:YES completionBlock:^(BOOL result) {
        NSLog(@"Connecte via Joint Page Thank you");
        if (result) {
            [self dismissViewControllerAnimated:YES completion:^{
//                appDelegate.isUserSessionStart = YES;
//                [appDelegate RequestLoadData];
            }];
        }
    }];

    
    
//    if (MyAppDelegate.session.isOpen) {
//        [MyAppDelegate.session closeAndClearTokenInformation];
//    } else {
//        if (MyAppDelegate.session.state != FBSessionStateCreated) {
//            MyAppDelegate.session = [[FBSession alloc] init];
//        }
//        [MyAppDelegate.session openWithCompletionHandler:^(FBSession *session,
//                                                         FBSessionState status,
//                                                         NSError *error) {
//            [self updateView];
//        }];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
