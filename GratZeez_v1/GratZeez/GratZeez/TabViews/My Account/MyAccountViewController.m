//
//  MyAccountViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 14/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "MyAccountViewController.h"

#import "ChangePasswordViewController.h"

@interface MyAccountViewController ()

@end

@implementation MyAccountViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *btnHelp = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(btnHelpAction:)];
    self.navigationItem.rightBarButtonItem=btnHelp;
    self.title = @"My Account";
  //  NSDictionary* textAttributes = [NSDictionary dictionaryWithObject: [UIColor whiteColor]
   //                                                            forKey: NSForegroundColorAttributeName];
    [btnHelp setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.view.backgroundColor=RGB(210, 200, 191);
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
        titleView.font = [UIFont fontWithName:GZFont size:16.0];
        titleView.textColor = [UIColor whiteColor];
        self.navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeGZNative) {
        return 2;
    }
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeFacebook) {
        return 1;
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeGZNative) {
        if (section==0) {
            return 1;
        }
        else if (section==1) {
            return 1;
        }
    }
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeFacebook) {
        if (section==0) {
            return 1;
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeGZNative) {
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                static NSString *CellIdentifier = @"CellChangePassword";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                cell.textLabel.font = [UIFont fontWithName:GZFont size:16.0f];
                cell.textLabel.text = @"Change Password";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor=RGB(210, 200, 191);
                return cell;
            }
        }
        else if (indexPath.section==1) {
            if (indexPath.row==0) {
                static NSString *CellIdentifier = @"CellLogOut";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                cell.textLabel.font = [UIFont fontWithName:GZFont size:16.0f];
                cell.textLabel.text = @"Logout";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor=RGB(210, 200, 191);
                return cell;
            }
        }
    }
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeFacebook) {
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                static NSString *CellIdentifier = @"CellLogOut";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                cell.textLabel.font = [UIFont fontWithName:GZFont size:16.0f];
                cell.textLabel.text = @"Logout";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor=RGB(210, 200, 191);
                return cell;
            }
        }
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeGZNative) {
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                ChangePasswordViewController *CPVC = [[ChangePasswordViewController alloc] initWithNibName:@"ChangePasswordViewController" bundle:nil];
                [self.navigationController pushViewController:CPVC animated:YES];
            }
        }
        else if (indexPath.section==1) {
            if (indexPath.row==0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                                message:@"Confirm Logout?"
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"Logout", nil];
                alert.tag=1;
                [alert show];
            }
        }
    }
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeFacebook) {
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                                message:@"Confirm Logout?"
                                                               delegate:self
                                                      cancelButtonTitle:@"Cancel"
                                                      otherButtonTitles:@"Logout", nil];
                alert.tag=1;
                [alert show];
            }
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag==1) {
        if (buttonIndex == 1) {
            
            [MyAppDelegate ClearLoginData];
            [MyAppDelegate LoginRequired:nil];
            [MyAppDelegate.tabBar setSelectedIndex:0];
            
//            UIImage *tabBarBackgroundImage = [UIImage imageNamed:@"request-tab.png"];
//            if([[[UIDevice currentDevice] systemVersion] floatValue]>4.9){
//                [MyAppDelegate.tabBar tabBar].backgroundImage = tabBarBackgroundImage;
//            }
//            else{
//                [[MyAppDelegate.tabBar tabBar] setBackgroundColor:[[UIColor alloc] initWithPatternImage:tabBarBackgroundImage]];
//            }
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [self.tableView reloadData];
}


@end
