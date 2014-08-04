//
//  HistoryInDetailViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 30/12/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "HistoryInDetailViewController.h"

@interface HistoryInDetailViewController ()

@end

@implementation HistoryInDetailViewController
@synthesize detailHistoryDataArray,lbl_From,lbl_To,lbl_user,lbl_serviceProvider,view_sender,view_serviceProvider,table_receiver,table_sender,ischarity;
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
    self.title=@"Detail History";
   
   // if ([self respondsToSelector:@selector(edgesForExtendedLayout)])self.edgesForExtendedLayout = UIRectEdgeNone;
        // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    
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
    NSArray *temp=[detailHistoryDataArray objectAtIndex:0];
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"service-provider"] boolValue]==1){
        lbl_From.text=@"From :";
        lbl_From.font=[UIFont fontWithName:GZFont size:17];
        lbl_serviceProvider.text=[temp objectAtIndex:0];
        lbl_serviceProvider.numberOfLines = 0;
        //lbl_user.font = [UIFont fontWithName:@"Helvetica" size:(15.0)];
        lbl_serviceProvider.lineBreakMode = NSLineBreakByWordWrapping;
        lbl_serviceProvider.textAlignment = NSTextAlignmentLeft;
        lbl_serviceProvider.font=[UIFont fontWithName:GZFont size:17];
        [lbl_serviceProvider sizeToFit];
        self.view=view_serviceProvider;
        NSLog(@"data of user:%@",detailHistoryDataArray);
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
        if(ischarity==TRUE){
            CGRect table_frame;
            table_frame=table_receiver.frame;
            table_frame.origin.x=1;
            table_frame.size.width=318;
            float height = [detailHistoryDataArray count]   * 50 +50 ; // 4*25.00
            NSLog(@"height of table: %f",height);
            if(height>=377){
                table_frame.size.height=377;
            }
            else{
                table_frame.size.height=height;
            }
            
            table_receiver.frame=table_frame;
            NSLog(@"table height %f",table_receiver.frame.size.height);
            [table_receiver reloadData];
            
        }
        else{
            CGRect table_frame;
            table_frame=table_receiver.frame;
            float height = [detailHistoryDataArray count]  * 50 +40 ; // 4*25.00
            NSLog(@"height of table: %f",height);
            table_frame.size.width=280;
            table_frame.origin.x=20;
            if(height>=377){
                table_frame.size.height=377;
            }
            else{
                table_frame.size.height=height;
            }
           
            table_receiver.frame=table_frame;
             [table_receiver reloadData];
        }
    }
    else if([[[NSUserDefaults standardUserDefaults] valueForKey:@"service-provider"] boolValue]==0){
        lbl_To.text=@"To :";
        lbl_To.font=[UIFont fontWithName:GZFont size:17];
        lbl_user.text=[temp objectAtIndex:0];
        lbl_user.font=[UIFont fontWithName:GZFont size:17];
        lbl_user.numberOfLines = 0;
        //lbl_user.font = [UIFont fontWithName:@"Helvetica" size:(15.0)];
        lbl_user.lineBreakMode = NSLineBreakByWordWrapping;
        lbl_user.textAlignment = NSTextAlignmentLeft;
        [lbl_user sizeToFit];
        self.view=view_sender;
        NSLog(@"data of user:%@",detailHistoryDataArray);
        CGRect table_frame;
        table_frame=table_sender.frame;
        float height = ([detailHistoryDataArray count]+1 )  * 40 +40 ; // 4*25.00
        NSLog(@"height of table: %f",height);
        if(height>=377){
            table_frame.size.height=377;
        }
        else{
            table_frame.size.height=height;
        }
        
        table_sender.frame=table_frame;
        [table_sender reloadData];
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    //return [SPLastTransactionDataArray count];
    if([detailHistoryDataArray count]==0){
        NSLog(@"return 0");
        return 1;
    }
    else
    {
        NSLog(@"return counr %d",[detailHistoryDataArray count]);
        return [detailHistoryDataArray count];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    // This will create a "invisible" footer
    if(ischarity==TRUE){
        NSLog(@"returned 50");
        return 50.0f;
    }
    else{
        NSLog(@"returned 40");
        return 40.0f;
    }
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
     UIView* headerView = [[UIView alloc]init];
    if(tableView==table_receiver){
        
        if(ischarity==TRUE){
            
   
    UILabel *lbl_srno = [[UILabel alloc] initWithFrame:CGRectMake(0,5,31,20)];
    [lbl_srno setFont:[UIFont fontWithName:GZFont size:11.0]];
    lbl_srno.numberOfLines = 0;
    lbl_srno.textColor=[UIColor whiteColor];
    lbl_srno.textAlignment = NSTextAlignmentCenter;
    lbl_srno.backgroundColor = [UIColor clearColor];
    lbl_srno.text=@"Sr No.";
    [headerView addSubview:lbl_srno];
    UILabel *lbl_gratuityAmount = [[UILabel alloc] initWithFrame:CGRectMake(33,0,46,40)];
    [lbl_gratuityAmount setFont:[UIFont fontWithName:GZFont size:11.0]];
    lbl_gratuityAmount.textAlignment = NSTextAlignmentCenter;
    lbl_gratuityAmount.textColor=[UIColor whiteColor];
    lbl_gratuityAmount.numberOfLines = 0;
    lbl_gratuityAmount.backgroundColor = [UIColor clearColor];
    lbl_gratuityAmount.text=@"Total Amount";
    lbl_gratuityAmount.lineBreakMode =NSLineBreakByWordWrapping;
    [headerView addSubview:lbl_gratuityAmount];
    UILabel *lbl_received = [[UILabel alloc] initWithFrame:CGRectMake(111,0,46,40)];
    [lbl_received setFont:[UIFont fontWithName:GZFont size:11.0]];
    lbl_received.textColor=[UIColor whiteColor];
    lbl_received.textAlignment = NSTextAlignmentCenter;
    lbl_received.numberOfLines = 0;
    lbl_received.backgroundColor = [UIColor clearColor];
    lbl_received.text=@"Amount Received";
    lbl_received.lineBreakMode =NSLineBreakByWordWrapping;
    [headerView addSubview:lbl_received];
    UILabel *lbl_donated = [[UILabel alloc] initWithFrame:CGRectMake(159,0,46,40)];
    [lbl_donated setFont:[UIFont fontWithName:GZFont size:11.0]];
    lbl_donated.textColor=[UIColor whiteColor];
    lbl_donated.textAlignment = NSTextAlignmentCenter;
    lbl_donated.numberOfLines = 0;
    lbl_donated.backgroundColor = [UIColor clearColor];
    lbl_donated.text=@"Donated To Charity";
    lbl_donated.lineBreakMode =NSLineBreakByWordWrapping;
    [headerView addSubview:lbl_donated];
    UILabel *lbl_detailTitle = [[UILabel alloc] initWithFrame:CGRectMake(210,0,40,40)];
    [lbl_detailTitle setFont:[UIFont fontWithName:GZFont size:11.0]];
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
    
    UIView* hSeparatorview1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 50)];
    hSeparatorview1.backgroundColor = [UIColor whiteColor];
    hSeparatorview1.tag = 1;
    [headerView addSubview:hSeparatorview1];
    
    UIView* hSeparatorview2 = [[UIView alloc] initWithFrame:CGRectMake(32, 0, 1, 50)];
    hSeparatorview2.backgroundColor = [UIColor whiteColor];
    hSeparatorview2.tag = 2;
    [headerView addSubview:hSeparatorview2];
    
    UIView* hSeparatorview3 = [[UIView alloc] initWithFrame:CGRectMake(110, 0, 1, 50)];
    hSeparatorview3.backgroundColor = [UIColor whiteColor];
    hSeparatorview3.tag = 3;
    [headerView addSubview:hSeparatorview3];
    
    UIView* hSeparatorview4 = [[UIView alloc] initWithFrame:CGRectMake(158, 0, 1, 50)];
    hSeparatorview4.backgroundColor = [UIColor whiteColor];
    hSeparatorview4.tag = 4;
    [headerView addSubview:hSeparatorview4];
    
    UIView* hSeparatorview5 = [[UIView alloc] initWithFrame:CGRectMake(204, 0, 1, 50)];
    hSeparatorview5.backgroundColor = [UIColor whiteColor];
    hSeparatorview5.tag = 5;
    [headerView addSubview:hSeparatorview5];
    
    UIView* hSeparatorview7 = [[UIView alloc] initWithFrame:CGRectMake(317, 0, 1, 50)];
    hSeparatorview7.backgroundColor = [UIColor whiteColor];
    hSeparatorview7.tag = 7;
    [headerView addSubview:hSeparatorview7];
        }
    }
    return headerView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.tableHeaderView=nil;
    tableView.contentInset=UIEdgeInsetsZero;
    tableView.backgroundColor=RGB(210, 200, 191);
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    NSString *SimpleTableIdentifier;
    UITableViewCell * cell;
       
    SimpleTableIdentifier = @"SimpleTableIdentifier";
    cell = [tableView  dequeueReusableCellWithIdentifier: nil];
    
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SimpleTableIdentifier];
        cell.backgroundColor=RGB(210, 200, 191);
    }
    
    return cell;
}

@end
