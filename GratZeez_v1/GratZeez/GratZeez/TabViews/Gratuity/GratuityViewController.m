//
//  GratuityViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 14/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "GratuityViewController.h"
#import "UIImageView+AFNetworking.h"

@interface GratuityViewController ()

@end

@implementation GratuityViewController

ViewRateViewController *viewRateVC;
Comment_UserListViewController *commentedUserListVC;
@synthesize lblWelcome,lbl_gratuitydisplay,lbl_lastTransaction,lblWelcome_serviceProvider,imgProfile_serviceProvider;
@synthesize imgProfile;
@synthesize view_sender,view_serviceProvider,tableview_serviceProvider;
@synthesize SPLastTransactionDataArray;
@synthesize txt_serviceProviderTotalGratuity,gratuityToolbar,lbl_currentBalance,txt_currentBalance;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSLog(@"tabbar is %@",tabBar.selectedItem);
    
}

-(void)sendrequestForGratuityViewController:(void (^)(BOOL result)) return_block{
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLGratuityPageInfo]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    [request setDelegate:self];
    NSDictionary *gratuityPageDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"],@"sender_id", nil];
    [request appendPostData:[[NSString stringWithFormat:@"%@",gratuityPageDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"gratuitypage dic%@",gratuityPageDictionary);
    [request setCompletionBlock:^{
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
        NSLog(@"==> ROOT: %@",root);
        if([root count]==0){
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:@"No data Found"
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
            return;
        }
        CGSize constraintSize = CGSizeMake(320, 18);  // Make changes in width as per your label requirement.
        
        CGRect textRect = [[root[@"currentBalance"] stringValue] boundingRectWithSize:constraintSize
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:@{NSFontAttributeName:[UIFont fontWithName:GZFont size:16]}
                                             context:nil];
        CGSize size = textRect.size;
        NSLog(@"width%f",size.width);
        NSLog(@"%@",root[@"currentBalance"]);
        if(root[@"currentBalance"]==0){
            lbl_grauity.frame=CGRectMake(240, 200,14, 18);
            lbl_grauity.text=@"0";
        }
        else{
            lbl_grauity.frame=CGRectMake(240, 200, size.width+5, 18);
            lbl_grauity.text=[NSString stringWithFormat:@"%@",[root[@"currentBalance"] stringValue]];
        }
        if([root[@"isError"] boolValue]==0){
            NSArray *temp=root[@"lastTransaction"];
                    NSLog(@"%@",temp[0]);
                    NSArray *temp1=temp[0];
                    lbl_lastTransaction.frame=CGRectMake(15, 230, 193, 18);
                    lbl_lastTransaction.font=[UIFont fontWithName:GZFont size:16];
                    if([temp1[0] isEqualToString:@"NULL"] && [temp1[1] isEqualToString:@"NULL"]){
                        lbl_lastTransaction.text=[NSString stringWithFormat:@"You have given $%@ to %@",temp1[3],temp1[2]];
                        
                    }
                else{
                    lbl_lastTransaction.text=[NSString stringWithFormat:@"You have given $%@ to %@ %@",temp1[3],temp1[0],temp1[1]];
                    }
            
            lbl_lastTransaction.numberOfLines = 0;
            
            lbl_lastTransaction.lineBreakMode = NSLineBreakByWordWrapping;
            lbl_lastTransaction.textAlignment = NSTextAlignmentLeft;
            [lbl_lastTransaction sizeToFit];
             [self.view addSubview:lbl_lastTransaction];
        }

        return_block(TRUE);
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

-(void)serviceProviderHomeTabRequest:(void (^)(BOOL result)) return_block{

    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLServiceProviderHome]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    [request setDelegate:self];
    NSDictionary *gratuityPageDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"],@"service_providerId", nil];
    [request appendPostData:[[NSString stringWithFormat:@"%@",gratuityPageDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"gratuitypage dic%@",gratuityPageDictionary);
    [request setCompletionBlock:^{
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
        NSLog(@"ServiceProviderHome Tab ROOT: %@",root);
        rate_no=root[@"averageRate"];
        rateView = [[DYRateView alloc] initWithFrame:CGRectMake(112, 140, 120, 20)
                                            fullStar:[UIImage imageNamed:@"StarFullLarge.png"]
                                           emptyStar:[UIImage imageNamed:@"StarEmptyLarge.png"]];
        rateView.padding = 2;
        NSLog(@"%@",rate_no);
        rateView.rate =[rate_no floatValue];
        NSLog(@"float %f",[rate_no floatValue]);
        NSLog(@"rate%f",rateView.rate);
        rateView.alignment = RateViewAlignmentLeft;
        rateView.editable = NO;
        lbl_currentBalance.font=[UIFont fontWithName:GZFont size:16];
    
        
        [self.view addSubview:rateView];
        txt_currentBalance.text=[root[@"totalBalance"] stringValue];
        txt_currentBalance.font=[UIFont fontWithName:GZFont size:15];
        if([root[@"currentBalance"] integerValue]==0){
            txt_serviceProviderTotalGratuity.text=@"0";
        }
        else{
        txt_serviceProviderTotalGratuity.text=[root[@"currentBalance"] stringValue];
        }
        txt_serviceProviderTotalGratuity.font=[UIFont fontWithName:GZFont size:15];
        NSLog(@"%@",rate_no);
        [self initializeSPDataArray:root[@"lastTransaction"] completion:^(BOOL result) {
            if(result){
                NSLog(@"array %@",SPLastTransactionDataArray);
                return_block(TRUE);
            }
        }];
        
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        NSLog(@"Error: %@",error.localizedDescription);
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:error.localizedDescription
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return_block(FALSE);
          }];
    [request startAsynchronous];

}
-(void)initializeSPDataArray:(NSMutableArray *)array completion:(void (^)(BOOL result)) return_block{
    SPLastTransactionDataArray=array;
    NSArray *temp;
    for (int i=0; i<[SPLastTransactionDataArray count]; i++) {
        temp=[SPLastTransactionDataArray objectAtIndex:i];
        NSLog(@"object %@",[temp objectAtIndex:3]);
        if(![[[temp objectAtIndex:3] stringValue] isEqualToString:@"0"]){
            ischarity=TRUE;
            NSLog(@"inside the loop");
            return_block(TRUE);
        }
    }
    return_block(TRUE);
}
- (void)viewWillAppear:(BOOL)animated {
    
    NSLog(@"~~~~~~~~~~~~~~~~~~~~~~~Gratuity View viewWillAppear %d",[[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] boolValue]);
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] boolValue]==1){
        //self.view=view_serviceProvider;
        view_serviceProvider.backgroundColor=[UIColor clearColor];
        self.view=view_serviceProvider;
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
      
        lblWelcome_serviceProvider.text = [NSString stringWithFormat:@"%@ %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"first_name"],[[NSUserDefaults standardUserDefaults] objectForKey:@"last_name"]];
        lblWelcome_serviceProvider.font=[UIFont fontWithName:GZFont size:18.0];
        txt_serviceProviderTotalGratuity.font=[UIFont fontWithName:GZFont size:16.0];
        lbl_totalGratuity.font=[UIFont fontWithName:GZFont size:16.0];
        ischarity=FALSE;
        [self serviceProviderHomeTabRequest:^(BOOL result) {
            if(result){
              //  ischarity=FALSE;
               
               
                CGRect frameTable;
                frameTable=tableview_serviceProvider.frame;
               
                float height;
                if(ischarity==TRUE){
                    if([SPLastTransactionDataArray count]==0){
                        height=100;
                    }
                    else{
                height = [SPLastTransactionDataArray count] * 40 +40 ;
                    }
                }
                else{
                    if ([SPLastTransactionDataArray count]==0) {
                        height=90;
                    }
                    else{
                height = [SPLastTransactionDataArray count] * 40 +40 ;
                    }
                }
                NSLog(@"height of table: %f",height);
                frameTable.size.height=height;
                tableview_serviceProvider.frame=frameTable;
                
                [tableview_serviceProvider reloadData];
                
            }
        }];
//        UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
//        [refreshControl addTarget:self action:@selector(handleRefresh:) forControlEvents:UIControlEventValueChanged];
//        [tableview_serviceProvider addSubview:refreshControl];
        NSString *urlString=[ImageURL stringByAppendingPathComponent:[[NSUserDefaults standardUserDefaults] valueForKey:@"profile-picture"]];
        imgProfile_serviceProvider.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
        imgProfile_serviceProvider.layer.cornerRadius = 3.0;
        imgProfile_serviceProvider.layer.masksToBounds = YES;
        imgProfile_serviceProvider.layer.borderWidth=0.5;
       // [[NSUserDefaults standardUserDefaults] valueForKey:@"profile-picture"];
    }
    else if([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] boolValue]==0){
        //self.view=view_sender;
        view_sender.backgroundColor=[UIColor clearColor];
        self.view=view_sender;
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
        lblWelcome.text = [NSString stringWithFormat:@"%@ %@",[[NSUserDefaults standardUserDefaults] objectForKey:@"first_name"],[[NSUserDefaults standardUserDefaults] objectForKey:@"last_name"]];
        lblWelcome.font=[UIFont fontWithName:GZFont size:16];
        NSString *urlString=[ImageURL stringByAppendingPathComponent:[[NSUserDefaults standardUserDefaults] valueForKey:@"profile-picture"]];
        NSLog(@"%@",urlString);
        imgProfile.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
        imgProfile.layer.cornerRadius = 3.0;
        imgProfile.layer.masksToBounds = YES;
        imgProfile.layer.borderWidth=0.5;
        if([[[NSUserDefaults standardUserDefaults] valueForKey:@"service-provider"] boolValue]==0){
            NSLog(@"request done");
            [self sendrequestForGratuityViewController:^(BOOL result){
                lbl_gratuitydisplay=[[UILabel alloc]initWithFrame:CGRectMake(15, 200, 220, 18)];
                
                lbl_gratuitydisplay.font=[UIFont fontWithName:GZFont size:16.0f];
                lbl_grauity.font=[UIFont fontWithName:GZFont size:16.0f];
                lbl_grauity.layer.borderWidth=1.0;
                lbl_grauity.layer.borderColor=[[UIColor grayColor]CGColor];
                [lbl_grauity.layer setCornerRadius:3];
                [lbl_grauity.layer setMasksToBounds:NO];
                lbl_grauity.textAlignment = NSTextAlignmentCenter;
                lbl_gratuitydisplay.text=@"Your Current Balance(in $) is:";
                [self.view addSubview:lbl_gratuitydisplay];
                [self.view addSubview:lbl_grauity];
                //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
                
            }];
        }
    }
    gratuityToolbar.frame=CGRectMake(0, 524, 320, 44);
    [self.view addSubview:gratuityToolbar];
    [gratuityToolbar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
}

-(IBAction)handleRefresh:(id)sender{
    NSLog(@"refresh");
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"Gratuity";
    //if ([self respondsToSelector:@selector(edgesForExtendedLayout)])self.edgesForExtendedLayout = UIRectEdgeNone;
//    NSLog(@"loaded success");
//    if (!MyAppDelegate.session.isOpen && !MyAppDelegate.isUserSessionStart) {
//        [MyAppDelegate LoginRequired:nil];
//    }
    UIBarButtonItem *btnHelp = [[UIBarButtonItem alloc] initWithTitle:@"Help" style:UIBarButtonItemStylePlain target:self action:@selector(btnHelpAction:)];
    self.navigationItem.rightBarButtonItem=btnHelp;
    //NSDictionary* textAttributes = [NSDictionary dictionaryWithObject: [UIColor whiteColor]
     //                                                          forKey: NSForegroundColorAttributeName];
    [btnHelp setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
  [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    lbl_grauity=[[UILabel alloc]init];
    lbl_lastTransaction=[[UILabel alloc]init];
    ischarity=FALSE;
    MyAppDelegate.tabBar.delegate=MyAppDelegate;
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ServiceProvider TableView Method.

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //return 2;
    if([SPLastTransactionDataArray count]==0){
        NSLog(@"returned 1 row");
        return 1;
    }
    else{
        NSLog(@"returned count");
    return [SPLastTransactionDataArray count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    // This will create a "invisible" footer
    if(ischarity==TRUE){
        return 40.0f;
    }
    else
    return 40.0f;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    float tableFont=14.0;
    
    UIView* headerView = [[UIView alloc]init];
    
    UILabel *lbl_srno = [[UILabel alloc] initWithFrame:CGRectMake(0,20,40,20)];
    [lbl_srno setFont:[UIFont fontWithName:GZFont size:14.0]];
    lbl_srno.textColor=[UIColor whiteColor];
    lbl_srno.numberOfLines = 0;
    lbl_srno.textAlignment = NSTextAlignmentCenter;
    lbl_srno.backgroundColor = [UIColor clearColor];
    lbl_srno.text=@"Sr No";
    [headerView addSubview:lbl_srno];
    UILabel *lbl_username = [[UILabel alloc] initWithFrame:CGRectMake(40,20,128,20)];
    [lbl_username setFont:[UIFont fontWithName:GZFont size:tableFont]];
    lbl_username.textColor=[UIColor whiteColor];
    lbl_username.numberOfLines = 0;
    lbl_username.backgroundColor = [UIColor clearColor];
    lbl_username.textAlignment = NSTextAlignmentLeft;
    lbl_username.text=@"Name";
    [headerView addSubview:lbl_username];
    if(ischarity==TRUE){
    UILabel *lbl_gratuityAmount = [[UILabel alloc] initWithFrame:CGRectMake(140,3,66,40)];
    [lbl_gratuityAmount setFont:[UIFont fontWithName:GZFont size:13]];
    lbl_gratuityAmount.textAlignment = NSTextAlignmentLeft;
    lbl_gratuityAmount.textColor=[UIColor whiteColor];
    lbl_gratuityAmount.numberOfLines = 0;
    lbl_gratuityAmount.backgroundColor = [UIColor clearColor];
    lbl_gratuityAmount.text=@"Total Amount";
    lbl_gratuityAmount.lineBreakMode =NSLineBreakByWordWrapping;
    [headerView addSubview:lbl_gratuityAmount];
    }
    else{
    UILabel *lbl_gratuityAmount = [[UILabel alloc] initWithFrame:CGRectMake(141,3,66,40)];
    [lbl_gratuityAmount setFont:[UIFont fontWithName:GZFont size:tableFont]];
    lbl_gratuityAmount.textAlignment = NSTextAlignmentLeft;
    lbl_gratuityAmount.textColor=[UIColor whiteColor];
    lbl_gratuityAmount.numberOfLines = 0;
    lbl_gratuityAmount.backgroundColor = [UIColor clearColor];
    lbl_gratuityAmount.text=@"Total Amount";
    lbl_gratuityAmount.lineBreakMode =NSLineBreakByWordWrapping;
    [headerView addSubview:lbl_gratuityAmount];
    }
    if(ischarity==TRUE){
    UILabel *lbl_receivedTitle = [[UILabel alloc] initWithFrame:CGRectMake(186,3,50,42)];
    [lbl_receivedTitle setFont:[UIFont fontWithName:GZFont size:13]];
    lbl_receivedTitle.textColor=[UIColor whiteColor];
    lbl_receivedTitle.textAlignment = NSTextAlignmentLeft;
    lbl_receivedTitle.numberOfLines = 0;
    lbl_receivedTitle.backgroundColor = [UIColor clearColor];
    lbl_receivedTitle.text=@"Amount Received";
    lbl_receivedTitle.lineBreakMode =NSLineBreakByWordWrapping;
    [headerView addSubview:lbl_receivedTitle];
    }
    else{
    UILabel *lbl_receivedTitle = [[UILabel alloc] initWithFrame:CGRectMake(202,3,80,40)];
    [lbl_receivedTitle setFont:[UIFont fontWithName:GZFont size:tableFont]];
    lbl_receivedTitle.textAlignment = NSTextAlignmentLeft;
    lbl_receivedTitle.textColor=[UIColor whiteColor];
    lbl_receivedTitle.numberOfLines = 0;
    lbl_receivedTitle.backgroundColor = [UIColor clearColor];
    lbl_receivedTitle.text=@"Amount Received";
    lbl_receivedTitle.lineBreakMode =NSLineBreakByWordWrapping;
    [headerView addSubview:lbl_receivedTitle];
    }
    if(ischarity==TRUE){
    UILabel *lbl_donateTitle = [[UILabel alloc] initWithFrame:CGRectMake(242,3,59,40)];
    [lbl_donateTitle setFont:[UIFont fontWithName:GZFont size:13]];
    lbl_donateTitle.textAlignment = NSTextAlignmentLeft;
    lbl_donateTitle.textColor=[UIColor whiteColor];
    lbl_donateTitle.numberOfLines = 0;
    lbl_donateTitle.backgroundColor = [UIColor clearColor];
    lbl_donateTitle.text=@"Donated To Charity";
    lbl_donateTitle.lineBreakMode =NSLineBreakByCharWrapping;
    [headerView addSubview:lbl_donateTitle];
    }
    headerView.backgroundColor = RGB(141, 113, 91);
    UIView *horizontalLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 301, 1)];
    horizontalLine.backgroundColor=[UIColor whiteColor];
    [headerView addSubview:horizontalLine];
    if(ischarity==TRUE){
    UIView* hSeparatorview1 = [[UIView alloc] initWithFrame:CGRectMake(36, 0, 1, 50)];
    hSeparatorview1.backgroundColor = [UIColor whiteColor];
    hSeparatorview1.tag = 1;
    [headerView addSubview:hSeparatorview1];
    
    UIView* hSeparatorview5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 50)];
    hSeparatorview5.backgroundColor = [UIColor whiteColor];
    hSeparatorview5.tag = 5;
    [headerView addSubview:hSeparatorview5];
    
    UIView* hSeparatorview2 = [[UIView alloc] initWithFrame:CGRectMake(138, 0, 1, 50)];
    hSeparatorview2.backgroundColor =[UIColor whiteColor];
    hSeparatorview2.tag = 2;
    [headerView addSubview:hSeparatorview2];
    }
    else{
        UIView* hSeparatorview1 = [[UIView alloc] initWithFrame:CGRectMake(36, 0, 1, 40)];
        hSeparatorview1.backgroundColor = [UIColor whiteColor];
        hSeparatorview1.tag = 1;
        [headerView addSubview:hSeparatorview1];
        
        UIView* hSeparatorview5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
        hSeparatorview5.backgroundColor = [UIColor whiteColor];
        hSeparatorview5.tag = 5;
        [headerView addSubview:hSeparatorview5];
        
        UIView* hSeparatorview2 = [[UIView alloc] initWithFrame:CGRectMake(138, 0, 1, 40)];
        hSeparatorview2.backgroundColor =[UIColor whiteColor];
        hSeparatorview2.tag = 2;
        [headerView addSubview:hSeparatorview2];
    }
    if(ischarity==TRUE){
    UIView* hSeparatorview3 = [[UIView alloc] initWithFrame:CGRectMake(184, 0, 1, 50)];
    hSeparatorview3.backgroundColor = [UIColor whiteColor];
    hSeparatorview3.tag = 3;
    [headerView addSubview:hSeparatorview3];
    }
    else{
        UIView* hSeparatorview3 = [[UIView alloc] initWithFrame:CGRectMake(200, 0, 1, 40)];
        hSeparatorview3.backgroundColor = [UIColor whiteColor];
        hSeparatorview3.tag = 3;
        [headerView addSubview:hSeparatorview3];
    }if(ischarity==TRUE){
    UIView* hSeparatorview4 = [[UIView alloc] initWithFrame:CGRectMake(300, 0, 1, 50)];
    hSeparatorview4.backgroundColor =[UIColor whiteColor];
    hSeparatorview4.tag = 4;
    [headerView addSubview:hSeparatorview4];
    }
    else{
        UIView* hSeparatorview4 = [[UIView alloc] initWithFrame:CGRectMake(300, 0, 1, 40)];
        hSeparatorview4.backgroundColor =[UIColor whiteColor];
        hSeparatorview4.tag = 4;
        [headerView addSubview:hSeparatorview4];
    }
    if(ischarity==TRUE){
    UIView* hSeparatorview6 = [[UIView alloc] initWithFrame:CGRectMake(240, 0, 1, 50)];
    hSeparatorview6.backgroundColor = [UIColor whiteColor];
    hSeparatorview6.tag = 6;
    [headerView addSubview:hSeparatorview6];
    }
    
    return headerView;

    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    tableView.tableHeaderView=nil;
    tableView.contentInset=UIEdgeInsetsZero;
    tableView.backgroundColor=[UIColor clearColor];
    //  tableView.backgroundColor=RGB(210, 200, 191);
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    NSString *SimpleTableIdentifier;
    UITableViewCell * cell;
    NSArray *tempDataArray=[SPLastTransactionDataArray objectAtIndex:indexPath.row];
    NSLog(@"tempData %@ count %d",tempDataArray,[SPLastTransactionDataArray count]);
    SimpleTableIdentifier = @"SimpleTableIdentifier";
    cell = [tableView  dequeueReusableCellWithIdentifier:@"LastTransactionCell"];
    
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SimpleTableIdentifier];
        cell.backgroundColor=RGB(210, 200,191);
        if([SPLastTransactionDataArray count]==0){
            cell.textLabel.text=@"No Last Transaction Found";
            cell.textLabel.textAlignment=NSTextAlignmentCenter;
            cell.textLabel.font=[UIFont fontWithName:GZFont size:15];
            UIView* horizontalview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 1)];
            horizontalview.backgroundColor = [UIColor whiteColor];
            
            horizontalview.tag = 7;
            [cell addSubview:horizontalview];
            UIView* horizontalfooterview = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 300, 1)];
            horizontalfooterview.backgroundColor = [UIColor whiteColor];
            
            horizontalfooterview.tag = 8;
            [cell addSubview:horizontalfooterview];
            UIView* hSeparatorview5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
            hSeparatorview5.backgroundColor = [UIColor whiteColor];
            
            hSeparatorview5.tag = 5;
            [cell addSubview:hSeparatorview5];
            UIView* hSeparatorview6 = [[UIView alloc] initWithFrame:CGRectMake(300, 0, 1, 40)];
            hSeparatorview6.backgroundColor = [UIColor whiteColor];
            hSeparatorview6.tag = 6;
            [cell addSubview:hSeparatorview6];
            return cell;
        }
        
        NSLog(@"hello");
        UILabel *lbl_srno = [[UILabel alloc] initWithFrame:CGRectMake(0,10,33,20)];
        [lbl_srno setFont:[UIFont fontWithName:GZFont  size:12.0]];
        lbl_srno.numberOfLines = 0;
        lbl_srno.textAlignment = NSTextAlignmentCenter;
        lbl_srno.backgroundColor = [UIColor clearColor];
        lbl_srno.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
        
        [cell addSubview:lbl_srno];
        
        UILabel *lbl_username = [[UILabel alloc] initWithFrame:CGRectMake(40,14,128,20)];
        [lbl_username setFont:[UIFont fontWithName:GZFont size:12.0]];
        lbl_username.numberOfLines = 0;
        lbl_username.lineBreakMode=NSLineBreakByWordWrapping;
        lbl_username.backgroundColor = [UIColor clearColor];
        lbl_username.textAlignment = NSTextAlignmentLeft;
        lbl_username.text =[tempDataArray objectAtIndex:0];
        [lbl_username sizeToFit];
        [cell addSubview:lbl_username];
        if(ischarity==TRUE){
        UILabel *lbl_gratuityAmount = [[UILabel alloc] initWithFrame:CGRectMake(126,10,66,20)];
        [lbl_gratuityAmount setFont:[UIFont fontWithName:GZFont size:12.0]];
        lbl_gratuityAmount.textAlignment = NSTextAlignmentCenter;
        lbl_gratuityAmount.numberOfLines = 0;
        lbl_gratuityAmount.backgroundColor = [UIColor clearColor];
        lbl_gratuityAmount.text = [[tempDataArray objectAtIndex:1] stringValue];
        [cell addSubview:lbl_gratuityAmount];
        }
        else{
            UILabel *lbl_gratuityAmount = [[UILabel alloc] initWithFrame:CGRectMake(129,10,66,20)];
            [lbl_gratuityAmount setFont:[UIFont fontWithName:GZFont size:12.0]];
            lbl_gratuityAmount.textAlignment = NSTextAlignmentCenter;
            lbl_gratuityAmount.numberOfLines = 0;
            lbl_gratuityAmount.backgroundColor = [UIColor clearColor];
            lbl_gratuityAmount.text = [[tempDataArray objectAtIndex:1] stringValue];
            [cell addSubview:lbl_gratuityAmount];
        }
        if(ischarity==TRUE){
        UILabel *lbl_receivedTitle = [[UILabel alloc] initWithFrame:CGRectMake(190,0,40,40)];
        [lbl_receivedTitle setFont:[UIFont fontWithName:GZFont size:12.0]];
        lbl_receivedTitle.textAlignment = NSTextAlignmentCenter;
        lbl_receivedTitle.numberOfLines = 0;
        lbl_receivedTitle.backgroundColor = [UIColor clearColor];
        lbl_receivedTitle.text=[[tempDataArray objectAtIndex:2] stringValue];
        lbl_receivedTitle.lineBreakMode =NSLineBreakByWordWrapping;
        [cell addSubview:lbl_receivedTitle];
        }
        else{
            UILabel *lbl_receivedTitle = [[UILabel alloc] initWithFrame:CGRectMake(220,0,40,40)];
            [lbl_receivedTitle setFont:[UIFont fontWithName:GZFont size:12.0]];
            lbl_receivedTitle.textAlignment = NSTextAlignmentCenter;
            lbl_receivedTitle.numberOfLines = 0;
            lbl_receivedTitle.backgroundColor = [UIColor clearColor];
            lbl_receivedTitle.text=[[tempDataArray objectAtIndex:2] stringValue];
            lbl_receivedTitle.lineBreakMode =NSLineBreakByWordWrapping;
            [cell addSubview:lbl_receivedTitle];
        }
        if(ischarity==TRUE){
            
        
        UILabel *lbl_donatedTitle = [[UILabel alloc] initWithFrame:CGRectMake(246,0,40,40)];
        [lbl_donatedTitle setFont:[UIFont fontWithName:GZFont  size:12.0]];
        lbl_donatedTitle.textAlignment = NSTextAlignmentCenter;
        lbl_donatedTitle.numberOfLines = 0;
        lbl_donatedTitle.backgroundColor = [UIColor clearColor];
        lbl_donatedTitle.text=[[tempDataArray objectAtIndex:3] stringValue];
        lbl_donatedTitle.lineBreakMode =NSLineBreakByWordWrapping;
        [cell addSubview:lbl_donatedTitle];
    }
    
        
        
        //create a hoizontal separator in cell to display it like column
        UIView* horizontalview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 1)];
        horizontalview.backgroundColor = [UIColor whiteColor];
        
        horizontalview.tag = 7;
        [cell addSubview:horizontalview];
        UIView* hSeparatorview1 = [[UIView alloc] initWithFrame:CGRectMake(36, 0, 1, 40)];
        hSeparatorview1.backgroundColor = [UIColor whiteColor];
        
        hSeparatorview1.tag = 1;
        [cell addSubview:hSeparatorview1];
        UIView* hSeparatorview5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
        hSeparatorview5.backgroundColor = [UIColor whiteColor];
        
        hSeparatorview5.tag = 5;
        [cell addSubview:hSeparatorview5];
        
        UIView* hSeparatorview2 = [[UIView alloc] initWithFrame:CGRectMake(138, 0, 1,40)];
        hSeparatorview2.backgroundColor = [UIColor whiteColor];
        hSeparatorview2.tag = 2;
        [cell addSubview:hSeparatorview2];
        if(ischarity==TRUE){
        UIView* hSeparatorview3 = [[UIView alloc] initWithFrame:CGRectMake(184, 0, 1, 40)];
        hSeparatorview3.backgroundColor = [UIColor whiteColor];
        hSeparatorview3.tag = 3;
        [cell addSubview:hSeparatorview3];
        }
        else{
            UIView* hSeparatorview3 = [[UIView alloc] initWithFrame:CGRectMake(200, 0, 1,40)];
            hSeparatorview3.backgroundColor = [UIColor whiteColor];
            hSeparatorview3.tag = 3;
            [cell addSubview:hSeparatorview3];
        }
        if(ischarity==TRUE){
        UIView* hSeparatorview4 = [[UIView alloc] initWithFrame:CGRectMake(240, 0, 1,40)];
        hSeparatorview4.backgroundColor = [UIColor whiteColor];
        hSeparatorview4.tag = 4;
        [cell addSubview:hSeparatorview4];
        }
        UIView* hSeparatorview6 = [[UIView alloc] initWithFrame:CGRectMake(300, 0, 1,40)];
        hSeparatorview6.backgroundColor = [UIColor whiteColor];
        hSeparatorview6.tag = 6;
        [cell addSubview:hSeparatorview6];
        if(indexPath.row==[SPLastTransactionDataArray count]-1){
            NSLog(@"last cell");
            UIView* horizontalfooterview = [[UIView alloc] initWithFrame:CGRectMake(0,39, 300, 1)];
            horizontalfooterview.backgroundColor = [UIColor whiteColor];
            
            horizontalfooterview.tag = 8;
            [cell addSubview:horizontalfooterview];
        }
        
    }
    
    return cell;

}
//- (void)tableView:(UITableView *)atableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    //get the cell which is selected
//    UITableViewCell *selectedCell = [atableView cellForRowAtIndexPath:indexPath];
//    
//    //set cell horizontal saparator view color of selected cell bcoz when cell selected all view color is gone
//    UIView *hSeparatorview1=[selectedCell viewWithTag:1];
//    hSeparatorview1.backgroundColor = [UIColor blackColor];
//    
//    UIView *hSeparatorview2=[selectedCell viewWithTag:2];
//    hSeparatorview2.backgroundColor = [UIColor blackColor];
//    UIView *hSeparatorview3=[selectedCell viewWithTag:3];
//    hSeparatorview3.backgroundColor = [UIColor blackColor];
//    UIView *hSeparatorview4=[selectedCell viewWithTag:4];
//    hSeparatorview4.backgroundColor = [UIColor blackColor];
//    UIView *hSeparatorview5=[selectedCell viewWithTag:5];
//    hSeparatorview5.backgroundColor = [UIColor blackColor];
//    UIView *horizontalview=[selectedCell viewWithTag:7];
//    horizontalview.backgroundColor = [UIColor blackColor];
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

- (IBAction)ViewCommentedUserList:(id)sender {
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLViewCommentedUserList]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    [request setDelegate:self];
    NSDictionary *viewRateDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"],@"service_providerId", nil];
    [request appendPostData:[[NSString stringWithFormat:@"%@",viewRateDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"rating dic%@",viewRateDictionary);
    [request setCompletionBlock:^{
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
        NSLog(@"view commented user list%@",root);
        if([root[@"isError"] boolValue]==1){
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:root[@"message"]
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
            return ;
        }
        commentedUserListVC=[[Comment_UserListViewController alloc]initWithNibName:@"Comment_UserListViewController" bundle:nil];
        [self initializeCommentListArray:root[@"commentedUserList"] completion:^(BOOL result) {
            if(result){
                
                [self.navigationController pushViewController:commentedUserListVC animated:YES];
            }
        }];
        
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
   
  //  [self.navigationController pushViewController:commentedUserListVC animated:YES];
}

- (IBAction)viewRating:(id)sender {
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLViewRate]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    [request setDelegate:self];
    NSDictionary *viewRateDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"],@"service_providerId", nil];
    [request appendPostData:[[NSString stringWithFormat:@"%@",viewRateDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"rating dic%@",viewRateDictionary);
    [request setCompletionBlock:^{
        NSDictionary *root = [NSJSONSerialization JSONObjectWithData:request.responseData options:0 error:nil];
        NSLog(@"rating root of receiver %@",root);
        if([root[@"isError"] boolValue]==1){
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeRed
                                           title:root[@"message"]
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
            return ;
        }
        viewRateVC=[[ViewRateViewController alloc]initWithNibName:@"ViewRateViewController" bundle:nil];
        [self initializeRateListArray:root[@"rateList"] completion:^(BOOL result) {
            if(result){
                
                [self.navigationController pushViewController:viewRateVC animated:YES];
            }
        }];
        
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

-(void)initializeCommentListArray:(NSMutableArray *)array completion:(void (^)(BOOL result)) return_block{
    commentedUserListVC.commentedUserListArray=array;
    return_block(TRUE);
}


-(void)initializeRateListArray:(NSMutableArray *)array completion:(void (^)(BOOL result)) return_block{
    viewRateVC.rateListDataArray=array;
    return_block(TRUE);
}
@end
