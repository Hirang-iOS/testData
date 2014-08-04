//
//  HistoryDetailViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 15/01/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import "HistoryDetailViewController.h"

@interface HistoryDetailViewController ()

@end

@implementation HistoryDetailViewController
@synthesize detailHistoryDataArray,lbl_From,lbl_serviceProvider,view_serviceProvider,ischarity,table_serviceProvider;
@synthesize lbl_To,lbl_user,view_sender,table_sender,historyDetailToolbar;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"Detail History";
    
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
   
    [self addLeftMenuButtonWithImage:[UIImage imageNamed:@"menu_icon"]];
    [self addrightMenuButtonWithImage:[UIImage imageNamed:@"help"]];
    
    
}

-(IBAction)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
   
        NSArray *temp=[detailHistoryDataArray objectAtIndex:0];
        
        if([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] isEqual:ServiceProvider]){
            lbl_From.text=@"From :";
            lbl_From.font=[UIFont fontWithName:GZFont size:17];
            lbl_serviceProvider.text=[temp objectAtIndex:0];
            lbl_serviceProvider.numberOfLines = 0;
            lbl_serviceProvider.lineBreakMode = NSLineBreakByWordWrapping;
            lbl_serviceProvider.textAlignment = NSTextAlignmentLeft;
            lbl_serviceProvider.font=[UIFont fontWithName:GZFont size:17];
            [lbl_serviceProvider sizeToFit];
            self.view=view_serviceProvider;

                CGRect table_frame;
                table_frame=table_serviceProvider.frame;
                table_frame.origin.x=1;
                table_frame.size.width=318;
                table_frame.origin.y=150;
                float height = [detailHistoryDataArray count] * 40 + 40 ; // 4*25.00
                NSLog(@"height of table: %f",height);
                int h=(int) height;
                if(h>=300){
                    table_serviceProvider=[[UITableView alloc]initWithFrame:CGRectMake(1, 150, 318, 300) style:UITableViewStylePlain];
                }
                else{
                    table_serviceProvider=[[UITableView alloc]initWithFrame:CGRectMake(1, 150, 318, height) style:UITableViewStylePlain];
                }
                table_serviceProvider.dataSource=self;
                table_serviceProvider.delegate=self;
                table_serviceProvider.bounces=FALSE;
                table_serviceProvider.separatorStyle=UITableViewCellSeparatorStyleNone;
                table_serviceProvider.allowsSelection=FALSE;
                [self.view addSubview:table_serviceProvider];
            
        }
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] isEqual:Sender]){
        lbl_To.text=@"To :";
        lbl_To.font=[UIFont fontWithName:GZFont size:17];
        lbl_user.text=[temp objectAtIndex:0];
        lbl_user.font=[UIFont fontWithName:GZFont size:17];
        lbl_user.numberOfLines = 0;
        NSLog(@"y %f",table_sender.frame.origin.y);
        lbl_user.lineBreakMode = NSLineBreakByWordWrapping;
        lbl_user.textAlignment = NSTextAlignmentLeft;
        [lbl_user sizeToFit];
        self.view=view_sender;
        NSLog(@"data of user:%@",detailHistoryDataArray);
        NSLog(@"deta count %d",[detailHistoryDataArray count]);
        float height = [detailHistoryDataArray count]  * 40 +40 ; // 4*25.00
        NSLog(@"height of table: %f",height);

        int h;
        h=(int) height;
        NSLog(@"%d",h);
        if(h>=300){
            NSLog(@"inside");
            table_sender=[[UITableView alloc]initWithFrame:CGRectMake(20, 150, 280, 300) style:UITableViewStylePlain];
                    }
        else{
            NSLog(@"inside 2");
        table_sender=[[UITableView alloc]initWithFrame:CGRectMake(20, 150, 280, height) style:UITableViewStylePlain];
            

        }
        table_sender.dataSource=self;
        table_sender.delegate=self;
        table_sender.bounces=FALSE;
        table_sender.separatorStyle=UITableViewCellSeparatorStyleNone;
        table_sender.allowsSelection=NO;
        [self.view addSubview:table_sender];
    }

    historyDetailToolbar.frame=CGRectMake(0, 524, 320, 44);
   NSLog(@"%f %f %f %f",self.view.frame.origin.y,self.view.frame.size.height,historyDetailToolbar.frame.origin.y,historyDetailToolbar.frame.size.height);
    [self.view addSubview:historyDetailToolbar];
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 21)];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *btnitem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    historyDetailToolbar.items=@[btnitem];
    [historyDetailToolbar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:rightRecognizer];
}
-(void)viewDidAppear:(BOOL)animated{
     NSLog(@"%f %f %f %f",self.view.frame.origin.y,self.view.frame.size.height,historyDetailToolbar.frame.origin.y,historyDetailToolbar.frame.size.height);
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* headerView = [[UIView alloc]init];
    if(tableView==table_serviceProvider){
        if(ischarity==TRUE){
            
            UILabel *lbl_srno = [[UILabel alloc] initWithFrame:CGRectMake(0,20,37,20)];
            [lbl_srno setFont:[UIFont fontWithName:GZFont size:13.0]];
            lbl_srno.numberOfLines = 0;
            lbl_srno.textColor=[UIColor whiteColor];
            lbl_srno.textAlignment = NSTextAlignmentCenter;
            lbl_srno.backgroundColor = [UIColor clearColor];
            lbl_srno.text=@"Sr No";
            [headerView addSubview:lbl_srno];
            UILabel *lbl_gratuityAmount = [[UILabel alloc] initWithFrame:CGRectMake(37,2,46,40)];
            [lbl_gratuityAmount setFont:[UIFont fontWithName:GZFont size:13]];
            lbl_gratuityAmount.textAlignment = NSTextAlignmentLeft;
            lbl_gratuityAmount.textColor=[UIColor whiteColor];
            lbl_gratuityAmount.numberOfLines = 0;
            lbl_gratuityAmount.backgroundColor = [UIColor clearColor];
            lbl_gratuityAmount.text=@"Total Amount";
            lbl_gratuityAmount.lineBreakMode =NSLineBreakByWordWrapping;
            [headerView addSubview:lbl_gratuityAmount];
            UILabel *lbl_received = [[UILabel alloc] initWithFrame:CGRectMake(86,2,50,40)];
            [lbl_received setFont:[UIFont fontWithName:GZFont size:13]];
            lbl_received.textColor=[UIColor whiteColor];
            lbl_received.textAlignment = NSTextAlignmentLeft;
            lbl_received.numberOfLines = 0;
            lbl_received.backgroundColor = [UIColor clearColor];
            lbl_received.text=@"Amount Received";
            lbl_received.lineBreakMode =NSLineBreakByWordWrapping;
            [headerView addSubview:lbl_received];
            UILabel *lbl_donated = [[UILabel alloc] initWithFrame:CGRectMake(149,2,60,40)];
            [lbl_donated setFont:[UIFont fontWithName:GZFont size:13.0]];
            lbl_donated.textColor=[UIColor whiteColor];
            lbl_donated.textAlignment = NSTextAlignmentLeft;
            lbl_donated.numberOfLines = 0;
            lbl_donated.backgroundColor = [UIColor clearColor];
            lbl_donated.text=@"Donated To Charity";
            lbl_donated.lineBreakMode =NSLineBreakByWordWrapping;
            [headerView addSubview:lbl_donated];
            UILabel *lbl_detailTitle = [[UILabel alloc] initWithFrame:CGRectMake(215,20,60,20)];
            [lbl_detailTitle setFont:[UIFont fontWithName:GZFont size:13.0]];
            lbl_detailTitle.textColor=[UIColor whiteColor];
            lbl_detailTitle.textAlignment = NSTextAlignmentLeft;
            lbl_detailTitle.numberOfLines = 0;
            lbl_detailTitle.backgroundColor = [UIColor clearColor];
            lbl_detailTitle.text=@"On Date";
            lbl_detailTitle.lineBreakMode =NSLineBreakByWordWrapping;
            [headerView addSubview:lbl_detailTitle];
            headerView.backgroundColor =RGB(141, 113, 91);
            
            UIView *horizontalLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 318, 1)];
            horizontalLine.backgroundColor=[UIColor whiteColor];
            [headerView addSubview:horizontalLine];
            
            UIView* hSeparatorview1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
            hSeparatorview1.backgroundColor = [UIColor whiteColor];
            hSeparatorview1.tag = 1;
            [headerView addSubview:hSeparatorview1];
            
            UIView* hSeparatorview2 = [[UIView alloc] initWithFrame:CGRectMake(34, 0, 1, 40)];
            hSeparatorview2.backgroundColor = [UIColor whiteColor];
            hSeparatorview2.tag = 2;
            [headerView addSubview:hSeparatorview2];
            
            UIView* hSeparatorview3 = [[UIView alloc] initWithFrame:CGRectMake(82, 0, 1, 40)];
            hSeparatorview3.backgroundColor = [UIColor whiteColor];
            hSeparatorview3.tag = 3;
            [headerView addSubview:hSeparatorview3];
            
            UIView* hSeparatorview4 = [[UIView alloc] initWithFrame:CGRectMake(148, 0, 1, 40)];
            hSeparatorview4.backgroundColor = [UIColor whiteColor];
            hSeparatorview4.tag = 4;
            [headerView addSubview:hSeparatorview4];
            
            UIView* hSeparatorview5 = [[UIView alloc] initWithFrame:CGRectMake(208, 0, 1, 40)];
            hSeparatorview5.backgroundColor = [UIColor whiteColor];
            hSeparatorview5.tag = 5;
            [headerView addSubview:hSeparatorview5];
            
            UIView* hSeparatorview7 = [[UIView alloc] initWithFrame:CGRectMake(317, 0, 1, 40)];
            hSeparatorview7.backgroundColor = [UIColor whiteColor];
            hSeparatorview7.tag = 7;
            [headerView addSubview:hSeparatorview7];
        }
        if(ischarity==FALSE){
            UILabel *lbl_srno = [[UILabel alloc] initWithFrame:CGRectMake(0,20,40,20)];
            [lbl_srno setFont:[UIFont fontWithName:GZFont size:14.0]];
            lbl_srno.numberOfLines = 0;
            lbl_srno.textColor=[UIColor whiteColor];
            lbl_srno.textAlignment = NSTextAlignmentLeft;
            lbl_srno.backgroundColor = [UIColor clearColor];
            lbl_srno.text=@"Sr No";
            [headerView addSubview:lbl_srno];
            UILabel *lbl_gratuityAmount = [[UILabel alloc] initWithFrame:CGRectMake(38,2,50,40)];
            [lbl_gratuityAmount setFont:[UIFont fontWithName:GZFont size:14.0]];
            lbl_gratuityAmount.textAlignment = NSTextAlignmentLeft;
            lbl_gratuityAmount.textColor=[UIColor whiteColor];
            lbl_gratuityAmount.numberOfLines = 0;
            lbl_gratuityAmount.backgroundColor = [UIColor clearColor];
            lbl_gratuityAmount.text=@"Total Amount";
            lbl_gratuityAmount.lineBreakMode =NSLineBreakByWordWrapping;
            [headerView addSubview:lbl_gratuityAmount];
            UILabel *lbl_received = [[UILabel alloc] initWithFrame:CGRectMake(112,2,55,40)];
            [lbl_received setFont:[UIFont fontWithName:GZFont size:14]];
            lbl_received.textColor=[UIColor whiteColor];
            lbl_received.textAlignment = NSTextAlignmentLeft;
            lbl_received.numberOfLines = 0;
            lbl_received.backgroundColor = [UIColor clearColor];
            lbl_received.text=@"Amount Received";
            lbl_received.lineBreakMode =NSLineBreakByWordWrapping;
            [headerView addSubview:lbl_received];
            UILabel *lbl_detailTitle = [[UILabel alloc] initWithFrame:CGRectMake(210,20,80,20)];
            [lbl_detailTitle setFont:[UIFont fontWithName:GZFont size:14.0]];
            lbl_detailTitle.textColor=[UIColor whiteColor];
            lbl_detailTitle.textAlignment = NSTextAlignmentLeft;
            lbl_detailTitle.numberOfLines = 0;
            lbl_detailTitle.backgroundColor = [UIColor clearColor];
            lbl_detailTitle.text=@"On Date";
            lbl_detailTitle.lineBreakMode =NSLineBreakByWordWrapping;
            [headerView addSubview:lbl_detailTitle];
            headerView.backgroundColor =RGB(141, 113, 91);
            
            UIView *horizontalLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 318, 1)];
            horizontalLine.backgroundColor=[UIColor whiteColor];
            [headerView addSubview:horizontalLine];
            
            UIView* hSeparatorview1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
            hSeparatorview1.backgroundColor = [UIColor whiteColor];
            hSeparatorview1.tag = 1;
            [headerView addSubview:hSeparatorview1];
            
            UIView* hSeparatorview2 = [[UIView alloc] initWithFrame:CGRectMake(35, 0, 1, 40)];
            hSeparatorview2.backgroundColor = [UIColor whiteColor];
            hSeparatorview2.tag = 2;
            [headerView addSubview:hSeparatorview2];
            
            UIView* hSeparatorview3 = [[UIView alloc] initWithFrame:CGRectMake(110, 0, 1, 40)];
            hSeparatorview3.backgroundColor = [UIColor whiteColor];
            hSeparatorview3.tag = 3;
            [headerView addSubview:hSeparatorview3];
            
            UIView* hSeparatorview5 = [[UIView alloc] initWithFrame:CGRectMake(204, 0, 1, 40)];
            hSeparatorview5.backgroundColor = [UIColor whiteColor];
            hSeparatorview5.tag = 5;
            [headerView addSubview:hSeparatorview5];
            
            UIView* hSeparatorview7 = [[UIView alloc] initWithFrame:CGRectMake(317, 0, 1, 40)];
            hSeparatorview7.backgroundColor = [UIColor whiteColor];
            hSeparatorview7.tag = 7;
            [headerView addSubview:hSeparatorview7];
        }
    }
    if(tableView==table_sender){
        UILabel *lbl_srno = [[UILabel alloc] initWithFrame:CGRectMake(0,20,40,20)];
        [lbl_srno setFont:[UIFont fontWithName:GZFont size:14.0]];
        lbl_srno.numberOfLines = 0;
        lbl_srno.textColor=[UIColor whiteColor];
        lbl_srno.textAlignment = NSTextAlignmentCenter;
        lbl_srno.backgroundColor = [UIColor clearColor];
        lbl_srno.text=@"Sr No";
        [headerView addSubview:lbl_srno];
        UILabel *lbl_gratuityAmount = [[UILabel alloc] initWithFrame:CGRectMake(40,20,50,20)];
        [lbl_gratuityAmount setFont:[UIFont fontWithName:GZFont size:14.0]];
        lbl_gratuityAmount.textAlignment = NSTextAlignmentLeft;
        lbl_gratuityAmount.textColor=[UIColor whiteColor];
        lbl_gratuityAmount.numberOfLines = 0;
        lbl_gratuityAmount.backgroundColor = [UIColor clearColor];
        lbl_gratuityAmount.text=@"Amount";
        lbl_gratuityAmount.lineBreakMode =NSLineBreakByWordWrapping;
        [headerView addSubview:lbl_gratuityAmount];
        UILabel *lbl_detailTitle = [[UILabel alloc] initWithFrame:CGRectMake(145,20,180,20)];
        [lbl_detailTitle setFont:[UIFont fontWithName:GZFont size:14.0]];
        lbl_detailTitle.textColor=[UIColor whiteColor];
        lbl_detailTitle.textAlignment = NSTextAlignmentLeft;
        lbl_detailTitle.numberOfLines = 0;
        lbl_detailTitle.backgroundColor = [UIColor clearColor];
        lbl_detailTitle.text=@"On Date";
        lbl_detailTitle.lineBreakMode =NSLineBreakByWordWrapping;
        [headerView addSubview:lbl_detailTitle];
        headerView.backgroundColor =RGB(141, 113, 91);
        
        UIView *horizontalLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 318, 1)];
        horizontalLine.backgroundColor=[UIColor whiteColor];
        [headerView addSubview:horizontalLine];
        
        UIView* hSeparatorview1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
        hSeparatorview1.backgroundColor = [UIColor whiteColor];
        hSeparatorview1.tag = 1;
        [headerView addSubview:hSeparatorview1];
        
        UIView* hSeparatorview2 = [[UIView alloc] initWithFrame:CGRectMake(37, 0, 1, 40)];
        hSeparatorview2.backgroundColor = [UIColor whiteColor];
        hSeparatorview2.tag = 2;
        [headerView addSubview:hSeparatorview2];
        
        
        UIView* hSeparatorview4 = [[UIView alloc] initWithFrame:CGRectMake(140, 0, 1, 40)];
        hSeparatorview4.backgroundColor = [UIColor whiteColor];
        hSeparatorview4.tag = 4;
        [headerView addSubview:hSeparatorview4];
        

        UIView* hSeparatorview7 = [[UIView alloc] initWithFrame:CGRectMake(279, 0, 1, 40)];
        hSeparatorview7.backgroundColor = [UIColor whiteColor];
        hSeparatorview7.tag = 7;
        [headerView addSubview:hSeparatorview7];
    }
    return headerView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"row==>%d",[detailHistoryDataArray count]);
    return [detailHistoryDataArray count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.tableHeaderView=nil;
    tableView.contentInset=UIEdgeInsetsZero;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    tableView.backgroundColor=RGB(210, 200, 191);
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    NSString *SimpleTableIdentifier;
    UITableViewCell * cell;
    NSArray *tempArray=[detailHistoryDataArray objectAtIndex:indexPath.row];
    SimpleTableIdentifier = @"SimpleTableIdentifier";
    cell = [tableView  dequeueReusableCellWithIdentifier: nil];
    NSLog(@"called");
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SimpleTableIdentifier];
        cell.backgroundColor=RGB(210, 200, 191);
        if(tableView==table_sender){
            UILabel *lbl_srno = [[UILabel alloc] initWithFrame:CGRectMake(0,10,31,20)];
            [lbl_srno setFont:[UIFont fontWithName:GZFont size:11.0]];
            lbl_srno.numberOfLines = 0;
            lbl_srno.textColor=[UIColor blackColor];
            lbl_srno.textAlignment = NSTextAlignmentCenter;
            lbl_srno.backgroundColor = [UIColor clearColor];
            lbl_srno.text=[NSString stringWithFormat:@"%d",indexPath.row+1];
            NSLog(@"index %d",indexPath.row+1);
            [cell addSubview:lbl_srno];
            UILabel *lbl_gratuityAmount = [[UILabel alloc] initWithFrame:CGRectMake(45,0,50,40)];
            [lbl_gratuityAmount setFont:[UIFont fontWithName:GZFont size:11.0]];
            lbl_gratuityAmount.textAlignment = NSTextAlignmentCenter;
            lbl_gratuityAmount.textColor=[UIColor blackColor];
            lbl_gratuityAmount.numberOfLines = 0;
            lbl_gratuityAmount.backgroundColor = [UIColor clearColor];
            lbl_gratuityAmount.text=[[tempArray objectAtIndex:1] stringValue];
            lbl_gratuityAmount.lineBreakMode =NSLineBreakByWordWrapping;
            [cell addSubview:lbl_gratuityAmount];
            UILabel *lbl_detailTitle = [[UILabel alloc] initWithFrame:CGRectMake(160,0,180,40)];
            [lbl_detailTitle setFont:[UIFont fontWithName:GZFont size:11.0]];
            lbl_detailTitle.textColor=[UIColor blackColor];
            lbl_detailTitle.textAlignment = NSTextAlignmentLeft;
            lbl_detailTitle.numberOfLines = 0;
            lbl_detailTitle.backgroundColor = [UIColor clearColor];
            lbl_detailTitle.text=[tempArray objectAtIndex:2];
            lbl_detailTitle.lineBreakMode =NSLineBreakByWordWrapping;
            [cell addSubview:lbl_detailTitle];
           
            
          
            
            UIView* hSeparatorview1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
            hSeparatorview1.backgroundColor = [UIColor whiteColor];
            hSeparatorview1.tag = 1;
            [cell addSubview:hSeparatorview1];
            
            UIView* hSeparatorview2 = [[UIView alloc] initWithFrame:CGRectMake(37, 0, 1, 40)];
            hSeparatorview2.backgroundColor = [UIColor whiteColor];
            hSeparatorview2.tag = 2;
            [cell addSubview:hSeparatorview2];
            
            
            UIView* hSeparatorview4 = [[UIView alloc] initWithFrame:CGRectMake(140, 0, 1, 40)];
            hSeparatorview4.backgroundColor = [UIColor whiteColor];
            hSeparatorview4.tag = 4;
            [cell addSubview:hSeparatorview4];
            
           
            UIView* hSeparatorview7 = [[UIView alloc] initWithFrame:CGRectMake(279, 0, 1, 40)];
            hSeparatorview7.backgroundColor = [UIColor whiteColor];
            hSeparatorview7.tag = 7;
            [cell addSubview:hSeparatorview7];
            
            UIView *horizontalLine=[[UIView alloc]initWithFrame:CGRectMake(0, 39, 280, 1)];
            horizontalLine.backgroundColor=[UIColor whiteColor];
            [cell addSubview:horizontalLine];
            
        }
        if(tableView==table_serviceProvider){
        if(ischarity==TRUE){
        UILabel *lbl_srno = [[UILabel alloc] initWithFrame:CGRectMake(0,10,31,20)];
        [lbl_srno setFont:[UIFont fontWithName:GZFont size:11.0]];
        lbl_srno.numberOfLines = 0;
        lbl_srno.textColor=[UIColor blackColor];
        lbl_srno.textAlignment = NSTextAlignmentCenter;
        lbl_srno.backgroundColor = [UIColor clearColor];
        lbl_srno.text=[NSString stringWithFormat:@"%d",indexPath.row+1];
        NSLog(@"%d",indexPath.row+1);
        [cell addSubview:lbl_srno];
        UILabel *lbl_gratuityAmount = [[UILabel alloc] initWithFrame:CGRectMake(33,0,46,40)];
        [lbl_gratuityAmount setFont:[UIFont fontWithName:GZFont size:11.0]];
        lbl_gratuityAmount.textAlignment = NSTextAlignmentCenter;
        lbl_gratuityAmount.textColor=[UIColor blackColor];
        lbl_gratuityAmount.numberOfLines = 0;
        lbl_gratuityAmount.backgroundColor = [UIColor clearColor];
        lbl_gratuityAmount.text=[[tempArray objectAtIndex:1] stringValue];
        lbl_gratuityAmount.lineBreakMode =NSLineBreakByWordWrapping;
        [cell addSubview:lbl_gratuityAmount];
        UILabel *lbl_received = [[UILabel alloc] initWithFrame:CGRectMake(85,0,46,40)];
        [lbl_received setFont:[UIFont fontWithName:GZFont size:11.0]];
        lbl_received.textColor=[UIColor blackColor];
        lbl_received.textAlignment = NSTextAlignmentCenter;
        lbl_received.numberOfLines = 0;
        lbl_received.backgroundColor = [UIColor clearColor];
        lbl_received.text=[[tempArray objectAtIndex:2] stringValue];
        lbl_received.lineBreakMode =NSLineBreakByWordWrapping;
        [cell addSubview:lbl_received];
        UILabel *lbl_donated = [[UILabel alloc] initWithFrame:CGRectMake(149,0,46,40)];
        [lbl_donated setFont:[UIFont fontWithName:GZFont size:11.0]];
        lbl_donated.textColor=[UIColor blackColor];
        lbl_donated.textAlignment = NSTextAlignmentCenter;
        lbl_donated.numberOfLines = 0;
        lbl_donated.backgroundColor = [UIColor clearColor];
        lbl_donated.text=[[tempArray objectAtIndex:3] stringValue];
        lbl_donated.lineBreakMode =NSLineBreakByWordWrapping;
        [cell addSubview:lbl_donated];
        UILabel *lbl_detailTitle = [[UILabel alloc] initWithFrame:CGRectMake(213,0,160,40)];
        [lbl_detailTitle setFont:[UIFont fontWithName:GZFont size:11.0]];
        lbl_detailTitle.textColor=[UIColor blackColor];
        lbl_detailTitle.textAlignment = NSTextAlignmentLeft;
        lbl_detailTitle.numberOfLines = 0;
        lbl_detailTitle.backgroundColor = [UIColor clearColor];
        lbl_detailTitle.text=[tempArray objectAtIndex:4];
        lbl_detailTitle.lineBreakMode =NSLineBreakByWordWrapping;
        [cell addSubview:lbl_detailTitle];
        UIView* hSeparatorview1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
        hSeparatorview1.backgroundColor = [UIColor whiteColor];
        hSeparatorview1.tag = 1;
        [cell addSubview:hSeparatorview1];
        
        UIView* hSeparatorview2 = [[UIView alloc] initWithFrame:CGRectMake(34, 0, 1, 40)];
        hSeparatorview2.backgroundColor = [UIColor whiteColor];
        hSeparatorview2.tag = 2;
        [cell addSubview:hSeparatorview2];
        
        UIView* hSeparatorview3 = [[UIView alloc] initWithFrame:CGRectMake(82, 0, 1, 40)];
        hSeparatorview3.backgroundColor = [UIColor whiteColor];
        hSeparatorview3.tag = 3;
        [cell addSubview:hSeparatorview3];
        
        UIView* hSeparatorview4 = [[UIView alloc] initWithFrame:CGRectMake(148, 0, 1, 40)];
        hSeparatorview4.backgroundColor = [UIColor whiteColor];
        hSeparatorview4.tag = 4;
        [cell addSubview:hSeparatorview4];
        
        UIView* hSeparatorview5 = [[UIView alloc] initWithFrame:CGRectMake(208, 0, 1, 40)];
        hSeparatorview5.backgroundColor = [UIColor whiteColor];
        hSeparatorview5.tag = 5;
        [cell addSubview:hSeparatorview5];
        
               
        UIView* horizontalfooterview = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 318, 1)];
        horizontalfooterview.backgroundColor = [UIColor whiteColor];
        
        horizontalfooterview.tag = 6;
        [cell addSubview:horizontalfooterview];
        
        UIView* hSeparatorview7 = [[UIView alloc] initWithFrame:CGRectMake(317, 0, 1, 40)];
        hSeparatorview7.backgroundColor = [UIColor whiteColor];
        hSeparatorview7.tag = 7;
        [cell addSubview:hSeparatorview7];
        if(indexPath.row==[detailHistoryDataArray count]-1){
            NSLog(@"last cell");
            UIView* horizontalfooterview = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 318, 1)];
            horizontalfooterview.backgroundColor = [UIColor whiteColor];
            
            horizontalfooterview.tag = 8;
            [cell addSubview:horizontalfooterview];
        }
    }
        if(ischarity==FALSE){
                UILabel *lbl_srno = [[UILabel alloc] initWithFrame:CGRectMake(0,10,31,20)];
                [lbl_srno setFont:[UIFont fontWithName:GZFont size:11.0]];
                lbl_srno.numberOfLines = 0;
                lbl_srno.textColor=[UIColor blackColor];
                lbl_srno.textAlignment = NSTextAlignmentCenter;
                lbl_srno.backgroundColor = [UIColor clearColor];
                lbl_srno.text=[NSString stringWithFormat:@"%d",indexPath.row+1];
                [cell addSubview:lbl_srno];
                UILabel *lbl_gratuityAmount = [[UILabel alloc] initWithFrame:CGRectMake(38,0,46,40)];
                [lbl_gratuityAmount setFont:[UIFont fontWithName:GZFont size:11.0]];
                lbl_gratuityAmount.textAlignment = NSTextAlignmentCenter;
                lbl_gratuityAmount.textColor=[UIColor blackColor];
                lbl_gratuityAmount.numberOfLines = 0;
                lbl_gratuityAmount.backgroundColor = [UIColor clearColor];
                lbl_gratuityAmount.text=[[tempArray objectAtIndex:1] stringValue];
                lbl_gratuityAmount.lineBreakMode =NSLineBreakByWordWrapping;
                [cell addSubview:lbl_gratuityAmount];
                UILabel *lbl_received = [[UILabel alloc] initWithFrame:CGRectMake(111,0,80,40)];
                [lbl_received setFont:[UIFont fontWithName:GZFont size:11.0]];
                lbl_received.textColor=[UIColor blackColor];
                lbl_received.textAlignment = NSTextAlignmentCenter;
                lbl_received.numberOfLines = 0;
                lbl_received.backgroundColor = [UIColor clearColor];
                lbl_received.text=[[tempArray objectAtIndex:2] stringValue];
                lbl_received.lineBreakMode =NSLineBreakByWordWrapping;
                [cell addSubview:lbl_received];
                UILabel *lbl_detailTitle = [[UILabel alloc] initWithFrame:CGRectMake(210,0,160,40)];
                [lbl_detailTitle setFont:[UIFont fontWithName:GZFont size:11.0]];
                lbl_detailTitle.textColor=[UIColor blackColor];
                lbl_detailTitle.textAlignment = NSTextAlignmentLeft;
                lbl_detailTitle.numberOfLines = 0;
                lbl_detailTitle.backgroundColor = [UIColor clearColor];
                lbl_detailTitle.text=[tempArray objectAtIndex:4];
                lbl_detailTitle.lineBreakMode =NSLineBreakByWordWrapping;
                [cell addSubview:lbl_detailTitle];
                
                UIView *horizontalLine=[[UIView alloc]initWithFrame:CGRectMake(0, 39, 318, 1)];
                horizontalLine.backgroundColor=[UIColor whiteColor];
                [cell addSubview:horizontalLine];
                
                UIView* hSeparatorview1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
                hSeparatorview1.backgroundColor = [UIColor whiteColor];
                hSeparatorview1.tag = 1;
                [cell addSubview:hSeparatorview1];
                
                UIView* hSeparatorview2 = [[UIView alloc] initWithFrame:CGRectMake(35, 0, 1, 40)];
                hSeparatorview2.backgroundColor = [UIColor whiteColor];
                hSeparatorview2.tag = 2;
                [cell addSubview:hSeparatorview2];
                
                UIView* hSeparatorview3 = [[UIView alloc] initWithFrame:CGRectMake(110, 0, 1, 40)];
                hSeparatorview3.backgroundColor = [UIColor whiteColor];
                hSeparatorview3.tag = 3;
                [cell addSubview:hSeparatorview3];
                
                //            UIView* hSeparatorview4 = [[UIView alloc] initWithFrame:CGRectMake(158, 0, 1, 40)];
                //            hSeparatorview4.backgroundColor = [UIColor whiteColor];
                //            hSeparatorview4.tag = 4;
                //            [headerView addSubview:hSeparatorview4];
                
                UIView* hSeparatorview5 = [[UIView alloc] initWithFrame:CGRectMake(204, 0, 1, 40)];
                hSeparatorview5.backgroundColor = [UIColor whiteColor];
                hSeparatorview5.tag = 5;
                [cell addSubview:hSeparatorview5];
                UIView* hSeparatorview7 = [[UIView alloc] initWithFrame:CGRectMake(317, 0, 1, 40)];
                hSeparatorview7.backgroundColor = [UIColor whiteColor];
                hSeparatorview7.tag = 7;
                [cell addSubview:hSeparatorview7];
            }
        }
    }
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
