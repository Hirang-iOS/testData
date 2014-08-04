//
//  MyAccountView.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 31/12/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "MyAccountView.h"
#import "ChangePasswordViewController.h"
@interface MyAccountView ()

@end

@implementation MyAccountView
Sender_HistoryViewController *SHVC;
EditProfileViewController *editProfileVC;
ServiceProviderEditProfileViewController *serviceProviderEditProfile;
RechargeViewController *RVC;
@synthesize view_sender,view_serviceProvider,tableview_sender,tableview_ServiceProvider,myAccountToolbar;
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
    self.title=@"My Account";
    UIBarButtonItem *btnHelp = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(btnHelpAction:)];
    self.navigationItem.rightBarButtonItem=btnHelp;
    [btnHelp setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    NSLog(@"login type%d",[[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue]);
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view from its nib.
    [self addLeftMenuButtonWithImage:[UIImage imageNamed:@"menu_icon"]];
    [self addrightMenuButtonWithImage:[UIImage imageNamed:@"help"]];
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
        titleView.font = [UIFont fontWithName:@"Garamond 3 SC" size:20.0];
        titleView.textColor = [UIColor whiteColor];
        self.navigationItem.titleView = titleView;
    }
    titleView.text = title;
    [titleView sizeToFit];
}
-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"serviceProvider %d",[[[NSUserDefaults standardUserDefaults] valueForKey:@"service-provider"] boolValue]);
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] isEqual:Sender]){
        //self.view=nil;
        NSLog(@"sender Confirm");
        self.view=view_sender;
        self.view.backgroundColor=RGB(210, 200, 191);
        [tableview_sender reloadData];
    }
    else{
        //self.view=nil;
        NSLog(@"serviceProvider Confirm");
        self.view=view_serviceProvider;
        self.view.backgroundColor=RGB(210, 200, 191);
        [tableview_ServiceProvider reloadData];
    }
    NSLog(@"%f %f",self.view.frame.origin.y,self.view.frame.size.height);
    myAccountToolbar.frame=CGRectMake(0,460, 320, 44);
    [self.view addSubview:myAccountToolbar];
    [myAccountToolbar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Tableview

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeGZNative) {
        if(tableView==tableview_sender){
            return 4;
        }
        if(tableView==tableview_ServiceProvider){
            return 3;
        }
    }
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeFacebook) {
        if(tableView==tableview_sender){
            return 3;
        }
        if(tableview_ServiceProvider){
            return 2;
        }
    }
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeGZNative) {
        return 1;
    }
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeFacebook) {

        return 1;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    tableView.separatorInset=UIEdgeInsetsZero;
    tableView.backgroundColor=RGB(210, 200, 191);
    UIView *view_cell=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    view_cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"carrot"]];
    UIView *sepratorLine=[[UIView alloc]initWithFrame:CGRectMake(0, 40, 320, 0.5)];
    sepratorLine.backgroundColor=[UIColor whiteColor];
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeGZNative) {
        if (tableView==tableview_sender) {
            if(indexPath.section==0){
                static NSString *CellIdentifier = @"CellHistory";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                cell.textLabel.font = [UIFont fontWithName:GZFont size:16.0f];
                cell.textLabel.text = @"History";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryView=view_cell;
                cell.backgroundColor=RGB(210, 200, 191);
                [cell.contentView addSubview:sepratorLine];
                return cell;
            }
            else if (indexPath.section==1) {
                static NSString *CellIdentifier = @"CellEditProfile";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                cell.textLabel.font = [UIFont fontWithName:GZFont size:16.0f];
                cell.textLabel.text = @"Edit Profile";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryView=view_cell;
                cell.backgroundColor=RGB(210, 200, 191);
                [cell.contentView addSubview:sepratorLine];
                return cell;
                
            }
            else if (indexPath.section==2) {
                static NSString *CellIdentifier = @"CellRechargeAccount";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                cell.textLabel.font = [UIFont fontWithName:GZFont size:16.0f];
                cell.textLabel.text = @"Recharge Account";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryView=view_cell;
                cell.backgroundColor=RGB(210, 200, 191);
                [cell.contentView addSubview:sepratorLine];
                return cell;
                
            }
            else if (indexPath.section==3) {
                static NSString *CellIdentifier = @"CellChangePassword";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                cell.textLabel.font = [UIFont fontWithName:GZFont size:16.0f];
                cell.textLabel.text = @"Change Password";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryView=view_cell;
                cell.backgroundColor=RGB(210, 200, 191);
                [cell.contentView addSubview:sepratorLine];
                return cell;
                
            }
        }
        else if (tableView==tableview_ServiceProvider){
            if (indexPath.section==0) {
                static NSString *CellIdentifier = @"CellEditProfile";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                cell.textLabel.font = [UIFont fontWithName:GZFont size:16.0f];
                cell.textLabel.text = @"Edit Profile";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor=RGB(210, 200, 191);
               [cell.contentView addSubview:sepratorLine];
                cell.accessoryView=view_cell;
                return cell;
                
            }
            else if (indexPath.section==1){
                static NSString *CellIdentifier = @"CellRequestForPayment";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                cell.textLabel.font = [UIFont fontWithName:GZFont size:16.0f];
                cell.textLabel.text = @"Request For Payment";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor=RGB(210, 200, 191);
                [cell.contentView addSubview:sepratorLine];
                cell.accessoryView=view_cell;
                return cell;
            }
           else if (indexPath.section==2) {
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
                    [cell.contentView addSubview:sepratorLine];
                    cell.accessoryView=view_cell;
                    return cell;
                
            }
        
        }
    }
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeFacebook) {
        if(tableView==tableview_sender){
            if(indexPath.section==0){
                static NSString *CellIdentifier = @"CellHistory";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                cell.textLabel.font = [UIFont fontWithName:GZFont size:16.0f];
                cell.textLabel.text = @"History";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.accessoryView=view_cell;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor=RGB(210, 200, 191);
                [cell.contentView addSubview:sepratorLine];
                return cell;
            }
            if(indexPath.section==1){
                static NSString *CellIdentifier = @"CellEditProfile";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                    cell.textLabel.font = [UIFont fontWithName:GZFont size:16.0f];
                    cell.textLabel.text = @"Edit Profile";
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.accessoryView=view_cell;
                    cell.backgroundColor=RGB(210, 200, 191);
                    [cell.contentView addSubview:sepratorLine];
                return cell;
                }
            if(indexPath.section==2){
                static NSString *CellIdentifier = @"CellRechargeAccount";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                cell.textLabel.font = [UIFont fontWithName:GZFont size:16.0f];
                cell.textLabel.text = @"Recharge Account";
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.accessoryView=view_cell;
                cell.backgroundColor=RGB(210, 200, 191);
                [cell.contentView addSubview:sepratorLine];
                return cell;
            }
                    }
        else if (tableView==tableview_ServiceProvider){
            if (indexPath.section==0) {
                static NSString *CellIdentifier = @"CellEditProfile";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                cell.textLabel.font = [UIFont fontWithName:GZFont size:16.0f];
                cell.textLabel.text = @"Edit Profile";
                cell.accessoryView=view_cell;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor=RGB(210, 200, 191);
                [cell.contentView addSubview:sepratorLine];
                return cell;
                
            }
            if(indexPath.section==1){
                static NSString *CellIdentifier = @"CellRequsetForPayment";
                UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
                if (cell == nil) {
                    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
                }
                cell.textLabel.font = [UIFont fontWithName:GZFont size:16.0f];
                cell.textLabel.text = @"Request For Payment";
                cell.accessoryView=view_cell;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.backgroundColor=RGB(210, 200, 191);
                [cell.contentView addSubview:sepratorLine];
                return cell;
            }
                    }
    }
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeGZNative) {
        if(tableView==tableview_sender)
        {
            if(indexPath.section==0){
                [self senderViewHistory];
            }
            
            else if (indexPath.section==1) {
                editProfileVC=[[EditProfileViewController alloc]initWithNibName:@"EditProfileViewController" bundle:nil];
                [self EditProfileAction:^(BOOL result) {
                    if (result) {
                        [self.navigationController pushViewController:editProfileVC animated:YES];
                    }
                }
                 ];
                
                
            }
            else if(indexPath.section==2){
                RVC=[[RechargeViewController alloc]initWithNibName:@"RechargeViewController" bundle:nil];
                [self.navigationController pushViewController:RVC animated:YES];
              //  [self getCurrentBal];
                
            }
            else if (indexPath.section==3) {
                ChangePasswordViewController *CPVC = [[ChangePasswordViewController alloc] initWithNibName:@"ChangePasswordViewController" bundle:nil];
                [self.navigationController pushViewController:CPVC animated:YES];
            
                }
            
                   }
        else if (tableView==tableview_ServiceProvider){
            if (indexPath.section==0) {
                //editProfileVC=[[EditProfileViewController alloc]initWithNibName:@"EditProfileViewController" bundle:nil];
                serviceProviderEditProfile=[[ServiceProviderEditProfileViewController alloc]initWithNibName:@"ServiceProviderEditProfileViewController" bundle:nil];
                [self ServiceProviderEditProfileAction:^(BOOL result) {
                    if (result) {
                        [self.navigationController pushViewController:serviceProviderEditProfile animated:YES];
                    }
                }
                 ];

                }
            else if (indexPath.section==1){
                
            }
           else if (indexPath.section==2) {
                ChangePasswordViewController *CPVC = [[ChangePasswordViewController alloc] initWithNibName:@"ChangePasswordViewController" bundle:nil];
                [self.navigationController pushViewController:CPVC animated:YES];
            }
         

        }
    }
    else if ([[[NSUserDefaults standardUserDefaults] valueForKey:@"UserLogedInType"] intValue] == LoginTypeFacebook) {
        if(tableView==tableview_sender){
            if(indexPath.section==0){
                [self senderViewHistory];
            }
            else if(indexPath.section==1){
                editProfileVC=[[EditProfileViewController alloc]initWithNibName:@"EditProfileViewController" bundle:nil];
                [self EditProfileAction:^(BOOL result) {
                    if (result) {
                        [self.navigationController pushViewController:editProfileVC animated:YES];
                    }
                }
                 ];

            }
            else if (indexPath.section==2){
                RVC=[[RechargeViewController alloc]initWithNibName:@"RechargeViewController" bundle:nil];
                [self.navigationController pushViewController:RVC animated:YES];
                 //[self getCurrentBal];
            }
            
        }
        else if (tableView==tableview_ServiceProvider){
            if(indexPath.section==0){
                serviceProviderEditProfile=[[ServiceProviderEditProfileViewController alloc]initWithNibName:@"ServiceProviderEditProfileViewController" bundle:nil];
                [self ServiceProviderEditProfileAction:^(BOOL result) {
                    if (result) {
                        [self.navigationController pushViewController:serviceProviderEditProfile animated:YES];
                    }
                }
                 ];

            }
            if(indexPath.section==1){
                
            }
           
        }
    }
}

//- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (alertView.tag==1) {
//        if (buttonIndex == 1) {
//            
//            [MyAppDelegate ClearLoginData];
//            [MyAppDelegate LoginRequired:nil];
//            [MyAppDelegate.tabBar setSelectedIndex:0];
//            
//        }
//    }
//}

-(void)senderViewHistory{
    SHVC=[[Sender_HistoryViewController alloc]initWithNibName:@"Sender_HistoryViewController" bundle:nil];
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLSenderHistory]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    NSDictionary *senderHistory=[[NSDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"],@"sender_id", nil];
    [request appendPostData:[[NSString stringWithFormat:@"%@",senderHistory] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@",senderHistory);
    [request setCompletionBlock:^{
        NSMutableDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
        NSLog(@"sender History root%@",root);
        if ([root[@"isError"] boolValue]==1) {
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:root[@"message"]
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
            return ;
        }
        [self initializeSenderHistoryArray:root[@"totalGratuity"] completionBlock:^(BOOL result) {
            if(result){
                [self.navigationController pushViewController:SHVC animated:YES];
            }
        }
         
         ];
        //               [self.navigationController pushViewController:SHVC animated:YES];
    }
     ];
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

-(void)EditProfileAction:(void (^)(BOOL result)) return_block{
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLSenderEditProfile]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    NSDictionary *senderEditProfile=[[NSDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"],@"sender_id", nil];
    [request appendPostData:[[NSString stringWithFormat:@"%@",senderEditProfile] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@",senderEditProfile);
    [request setCompletionBlock:^{
        NSMutableDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
        NSLog(@"Sender EditProfile %@",root);
     //   [editProfileDictionary[@"zipcode"] isEqual:(id)[NSNull null]]
        if([root[@"data"] isEqual:(id)[NSNull null]]){
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:root[@"message"]
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
            return ;
        }
        else{
        [self intializeEditProfileArray:root[@"data"] tag:0 charityArray:nil completionBloack:^(BOOL result) {
            if(result){
                return_block(TRUE);
            }
        }];
        }
        
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error: %@",error.localizedDescription);
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:error.localizedDescription
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
    }];
    [request startAsynchronous];
}

-(void)ServiceProviderEditProfileAction:(void (^)(BOOL result)) return_block{
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLServiceProviderEditProfile]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    NSDictionary *senderEditProfile=[[NSDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"],@"service_providerId", nil];
    [request appendPostData:[[NSString stringWithFormat:@"%@",senderEditProfile] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@",senderEditProfile);
    [request setCompletionBlock:^{
        NSMutableDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
        NSLog(@"Service EditProfile %@",root);
        if([root[@"data"] isEqual:(id)[NSNull null]]){
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:root[@"message"]
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
            return ;
        }
        else{
        [self intializeEditProfileArray:root[@"data"] tag:1 charityArray:root[@"charityList"] completionBloack:^(BOOL result) {
            if(result){
               
                return_block(TRUE);
            }
        }];
        }
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error: %@",error.localizedDescription);
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:error.localizedDescription
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
    }];
    [request startAsynchronous];
}

-(void)intializeEditProfileArray:(NSMutableDictionary *)dictionary tag:(int )tag charityArray:(NSMutableArray *)charrityData completionBloack:(void (^)(BOOL result)) return_block{
    if(tag==0){
    editProfileVC.editProfileDictionary=dictionary;
    }
    if(tag==1){
        serviceProviderEditProfile.editProfileDictionay=dictionary;

    }
    return_block(TRUE);
}
-(void)initializeSenderHistoryArray:(NSMutableArray *)array completionBlock:(void (^)(BOOL result)) return_block{
    SHVC.senderHistoryDataArray=array;
    return_block(TRUE);
}

@end
