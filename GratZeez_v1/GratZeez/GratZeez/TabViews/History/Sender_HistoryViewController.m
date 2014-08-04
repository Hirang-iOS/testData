//
//  Sender_HistoryViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 15/01/14.
//  Copyright (c) 2014 cloudZon Infosoft. All rights reserved.
//

#import "Sender_HistoryViewController.h"

@interface Sender_HistoryViewController ()

@end

@implementation Sender_HistoryViewController
@synthesize senderHistoryDataArray,sender_table,senderHistoryToolbar;
HistoryDetailViewController *historyVC;
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
-(void)viewWillAppear:(BOOL)animated{
     NSLog(@"%f %f %f ==%f",self.view.frame.origin.y,self.view.frame.size.height,senderHistoryToolbar.frame.origin.y,senderHistoryToolbar.frame.size.height);
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title=@"History";
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background_half"]];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    float height=[senderHistoryDataArray count]* 40+40+1;
    NSLog(@"%f",height);
    int h=(int) height;
    if(h>=300){
        sender_table=[[UITableView alloc]initWithFrame:CGRectMake(20, 80, 280, 281) style:UITableViewStylePlain];
    }
    else{
        sender_table=[[UITableView alloc]initWithFrame:CGRectMake(20, 80, 280, height) style:UITableViewStylePlain];
    }
    // sender_table=[[UITableView alloc]initWithFrame:CGRectMake(20, 150, 280, 240) style:UITableViewStylePlain];
    sender_table.dataSource=self;
    sender_table.delegate=self;
    sender_table.tableHeaderView=nil;
    sender_table.tableFooterView=[self footerView];
    sender_table.bounces=FALSE;
    sender_table.allowsSelection=FALSE;
    sender_table.separatorStyle=UITableViewCellSeparatorStyleNone;
    [self.view addSubview:sender_table];
    senderHistoryToolbar.frame=CGRectMake(0, 524, 320, 44);
    [self.view addSubview:senderHistoryToolbar];
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 21)];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *btnitem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    senderHistoryToolbar.items=@[btnitem];
    [senderHistoryToolbar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    [self addLeftMenuButtonWithImage:[UIImage imageNamed:@"menu_icon"]];
    [self addrightMenuButtonWithImage:[UIImage imageNamed:@"help"]];
    
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
    rightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [rightRecognizer setNumberOfTouchesRequired:1];
    [self.view addGestureRecognizer:rightRecognizer];
       // Do any additional setup after loading the view from its nib.
}
-(IBAction)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIView *)footerView{
    UIView *footerview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 1)];
    footerview.backgroundColor=[UIColor whiteColor];
    return footerview;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"%d",[senderHistoryDataArray count]);
    return [senderHistoryDataArray count];
    //    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    tableView.tableHeaderView=nil;
    self.edgesForExtendedLayout=UIRectEdgeNone;
    //tableView.contentInset=UIEdgeInsetsZero;
    NSLog(@"%f",tableView.frame.size.height);
    tableView.backgroundColor=RGB(210, 200, 191);
    // [tableView setSeparatorInset:UIEdgeInsetsZero];
    NSString *SimpleTableIdentifier;
    UITableViewCell * cell;
    NSArray *tempDataArray=[senderHistoryDataArray objectAtIndex:indexPath.row];
    SimpleTableIdentifier = @"SimpleTableIdentifier";
    cell = [tableView  dequeueReusableCellWithIdentifier: nil];
    NSLog(@"called");
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SimpleTableIdentifier];
        cell.backgroundColor=RGB(210, 200, 191);
    }
    if([senderHistoryDataArray count]==0){
        cell.textLabel.text=@"No Last Transaction Found";
        cell.textLabel.textAlignment=NSTextAlignmentCenter;
        cell.textLabel.font=[UIFont fontWithName:GZFont size:15];
        
        UIView* horizontalview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 1)];
        horizontalview.backgroundColor = [UIColor whiteColor];
        horizontalview.tag = 7;
        [cell addSubview:horizontalview];
        
        UIView* horizontalfooterview = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 280, 1)];
        horizontalfooterview.backgroundColor = [UIColor whiteColor];
        
        horizontalfooterview.tag = 8;
        [cell addSubview:horizontalfooterview];
        UIView* hSeparatorview5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
        hSeparatorview5.backgroundColor = [UIColor whiteColor];
        
        hSeparatorview5.tag = 5;
        [cell addSubview:hSeparatorview5];
        UIView* hSeparatorview6 = [[UIView alloc] initWithFrame:CGRectMake(279, 0, 1, 40)];
        hSeparatorview6.backgroundColor = [UIColor whiteColor];
        hSeparatorview6.tag = 6;
        [cell addSubview:hSeparatorview6];
        return cell;
    }
    else{
        UILabel *lbl_srno = [[UILabel alloc] initWithFrame:CGRectMake(0,5,33,20)];
        [lbl_srno setFont:[UIFont fontWithName:GZFont size:12.0]];
        lbl_srno.numberOfLines = 0;
        lbl_srno.textAlignment = NSTextAlignmentCenter;
        lbl_srno.backgroundColor = [UIColor clearColor];
        lbl_srno.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
        
        [cell addSubview:lbl_srno];
        
        UILabel *lbl_username = [[UILabel alloc] initWithFrame:CGRectMake(40,5,128,20)];
        [lbl_username setFont:[UIFont fontWithName:GZFont size:12.0]];
        lbl_username.numberOfLines = 0;
        lbl_username.backgroundColor = [UIColor clearColor];
        lbl_username.textAlignment = NSTextAlignmentLeft;
        lbl_username.text =[tempDataArray objectAtIndex:0];
        [cell addSubview:lbl_username];
        
        UILabel *lbl_gratuityAmount = [[UILabel alloc] initWithFrame:CGRectMake(180,5,66,20)];
        [lbl_gratuityAmount setFont:[UIFont fontWithName:GZFont size:12.0]];
        lbl_gratuityAmount.textAlignment = NSTextAlignmentLeft;
        lbl_gratuityAmount.numberOfLines = 0;
        lbl_gratuityAmount.backgroundColor = [UIColor clearColor];
        lbl_gratuityAmount.text = [[tempDataArray objectAtIndex:2] stringValue];
        [cell addSubview:lbl_gratuityAmount];
        
        UIButton *previewButton=[UIButton buttonWithType:UIButtonTypeCustom];
        previewButton.frame=CGRectMake(220, 3, 66, 40);
        //[previewButton setTitle:@"Details" forState:UIControlStateNormal];
        //[previewButton setTitleColor:RGB(110, 73, 44) forState:UIControlStateNormal];
        [previewButton setImage:[UIImage imageNamed:@"details"] forState:UIControlStateNormal];
        [previewButton addTarget:self action:@selector(detailViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [previewButton setTag:indexPath.row];
        [cell addSubview:previewButton];
        
        UIView* hSeparatorview1 = [[UIView alloc] initWithFrame:CGRectMake(36, 0, 1, 40)];
        hSeparatorview1.backgroundColor = [UIColor whiteColor];
        
        hSeparatorview1.tag = 1;
        [cell addSubview:hSeparatorview1];
        UIView* hSeparatorview5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
        hSeparatorview5.backgroundColor = [UIColor whiteColor];
        
        hSeparatorview5.tag = 5;
        [cell addSubview:hSeparatorview5];
        
        UIView* hSeparatorview2 = [[UIView alloc] initWithFrame:CGRectMake(165, 0, 1, 40)];
        hSeparatorview2.backgroundColor = [UIColor whiteColor];
        hSeparatorview2.tag = 2;
        [cell addSubview:hSeparatorview2];
        UIView* hSeparatorview3 = [[UIView alloc] initWithFrame:CGRectMake(220, 0, 1, 40)];
        hSeparatorview3.backgroundColor = [UIColor whiteColor];
        hSeparatorview3.tag = 3;
     //   [cell addSubview:hSeparatorview3];
        UIView* hSeparatorview4 = [[UIView alloc] initWithFrame:CGRectMake(279, 0, 1, 40)];
        hSeparatorview4.backgroundColor = [UIColor whiteColor];
        hSeparatorview4.tag = 4;
        [cell addSubview:hSeparatorview4];
        if(indexPath.row==[senderHistoryDataArray count]-1){
            
        }
        else{
            UIView* horizontalfooterview = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 280, 1)];
            horizontalfooterview.backgroundColor = [UIColor whiteColor];
            horizontalfooterview.tag = 8;
            [cell addSubview:horizontalfooterview];
        }
        }
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView* headerView = [[UIView alloc]init];
    
    UILabel *lbl_srno = [[UILabel alloc] initWithFrame:CGRectMake(0,20,40,20)];
    [lbl_srno setFont:[UIFont fontWithName:GZFont size:14.0]];
    lbl_srno.numberOfLines = 0;
    lbl_srno.textAlignment = NSTextAlignmentLeft;
    lbl_srno.backgroundColor = [UIColor clearColor];
    lbl_srno.text=@"Sr No";
    lbl_srno.textColor=[UIColor whiteColor];
    [headerView addSubview:lbl_srno];
    UILabel *lbl_username = [[UILabel alloc] initWithFrame:CGRectMake(40,20,128,20)];
    [lbl_username setFont:[UIFont fontWithName:GZFont size:14.0]];
    lbl_username.numberOfLines = 0;
    lbl_username.backgroundColor = [UIColor clearColor];
    lbl_username.textAlignment = NSTextAlignmentLeft;
    lbl_username.textColor=[UIColor whiteColor];
    lbl_username.text=@"Given To";
    [headerView addSubview:lbl_username];
    UILabel *lbl_gratuityAmount = [[UILabel alloc] initWithFrame:CGRectMake(167,20,66,20)];
    [lbl_gratuityAmount setFont:[UIFont fontWithName:GZFont size:14.0]];
    lbl_gratuityAmount.textAlignment = NSTextAlignmentLeft;
    lbl_gratuityAmount.numberOfLines = 0;
    lbl_gratuityAmount.textColor=[UIColor whiteColor];
    lbl_gratuityAmount.backgroundColor = [UIColor clearColor];
    lbl_gratuityAmount.text=@"Amount";
    [headerView addSubview:lbl_gratuityAmount];
    UILabel *lbl_detailTitle = [[UILabel alloc] initWithFrame:CGRectMake(229,0,40,40)];
    [lbl_detailTitle setFont:[UIFont fontWithName:GZFont size:14.0]];
    lbl_detailTitle.textAlignment = NSTextAlignmentLeft;
    lbl_detailTitle.numberOfLines = 0;
    lbl_detailTitle.textColor=[UIColor whiteColor];
    lbl_detailTitle.backgroundColor = [UIColor clearColor];
    lbl_detailTitle.text=@"Click For Details";
    lbl_detailTitle.lineBreakMode =NSLineBreakByWordWrapping;
   // [headerView addSubview:lbl_detailTitle];
    headerView.backgroundColor =RGB(141, 113, 91);
    
    UIView *horizontalLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 1)];
    horizontalLine.backgroundColor=[UIColor whiteColor];
    [headerView addSubview:horizontalLine];
    
    UIView* hSeparatorview1 = [[UIView alloc] initWithFrame:CGRectMake(36, 0, 1, 40)];
    hSeparatorview1.backgroundColor = [UIColor whiteColor];
    hSeparatorview1.tag = 1;
    [headerView addSubview:hSeparatorview1];
    
    UIView* hSeparatorview5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
    hSeparatorview5.backgroundColor = [UIColor whiteColor];
    hSeparatorview5.tag = 5;
    [headerView addSubview:hSeparatorview5];
    
    UIView* hSeparatorview2 = [[UIView alloc] initWithFrame:CGRectMake(165, 0, 1, 40)];
    hSeparatorview2.backgroundColor = [UIColor whiteColor];
    hSeparatorview2.tag = 2;
    [headerView addSubview:hSeparatorview2];
    UIView* hSeparatorview3 = [[UIView alloc] initWithFrame:CGRectMake(220, 0, 1, 40)];
    hSeparatorview3.backgroundColor = [UIColor whiteColor];
    hSeparatorview3.tag = 3;
   // [headerView addSubview:hSeparatorview3];
    UIView* hSeparatorview4 = [[UIView alloc] initWithFrame:CGRectMake(279, 0, 1, 40)];
    hSeparatorview4.backgroundColor = [UIColor whiteColor];
    hSeparatorview4.tag = 4;
    [headerView addSubview:hSeparatorview4];
    return headerView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40.0f;
}

-(IBAction)detailViewAction:(id)sender{
    
    NSLog(@"sender tag:%d",[sender tag]);
    NSArray *tempDataArray=[senderHistoryDataArray objectAtIndex:[sender tag]];
    NSLog(@"details of:%@",tempDataArray);
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLSenderDetailHistory]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    NSDictionary *senderDetailHistory=[[NSDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"],@"sender_id",[[tempDataArray objectAtIndex:1] stringValue],@"service_providerId", nil];
    [request appendPostData:[[NSString stringWithFormat:@"%@",senderDetailHistory] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@",senderDetailHistory);
    [request setCompletionBlock:^{
        NSMutableDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
        NSLog(@"details history root%@",root);
        historyVC=[[HistoryDetailViewController alloc]initWithNibName:@"HistoryDetailViewController" bundle:nil];
        [self initializeSenderHistoryArray:root[@"detailsHistory"]  completionBlock:^(BOOL result) {
            
            if(result){
                [self.navigationController pushViewController:historyVC animated:YES];
            }
            
        }];
    }];
    [request startAsynchronous];
}

-(void)initializeSenderHistoryArray:(NSMutableArray *)ary completionBlock:(void (^)(BOOL result)) return_block{
    historyVC.detailHistoryDataArray=ary;
    return_block(TRUE);
    
}

/*
 -(void)viewWillAppear:(BOOL)animated{
 
 self.title = @"History";
 
 
 self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
 
 //  historyDataArray=root[@"totalGratuity"];
 
 
 CGRect frameTable;
 float height;
 frameTable=historyTable.frame;
 frameTable.size.width=318;
 frameTable.origin.x=1;
 if([senderHistoryDataArray count]==0){
 height=100;
 }else{
 height = [senderHistoryDataArray count] * 50 +50 ; // 4*25.00
 }
 NSLog(@"height of table: %f",height);
 frameTable.size.height=height;
 historyTable.frame=frameTable;
 
 [historyTable reloadData];
 
 
 
 
 
 }
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
 
 
 //return [SPLastTransactionDataArray count];
 if([senderHistoryDataArray count]==0){
 NSLog(@"return 0");
 return 1;
 }
 else
 {
 NSLog(@"return counr %d",[senderHistoryDataArray count]);
 return [senderHistoryDataArray count];
 }
 }
 
 - (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
 // This will create a "invisible" footer
 return 0.01f;
 }
 
 //- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
 //{
 //    UIView* horizontalview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 1)];
 //    horizontalview.backgroundColor = [UIColor blackColor];
 //    return horizontalview;
 //
 //}
 
 //- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
 //    // This will create a "invisible" footer
 //    return 40.0f;
 //}
 
 - (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
 // This will create a "invisible" footer
 
 NSLog(@"returned 50");
 return 50.0f;
 
 }
 - (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
 {
 
 UIView* headerView = [[UIView alloc]init];
 
 UILabel *lbl_srno = [[UILabel alloc] initWithFrame:CGRectMake(0,5,33,20)];
 [lbl_srno setFont:[UIFont fontWithName:GZFont size:11.0]];
 lbl_srno.numberOfLines = 0;
 lbl_srno.textAlignment = NSTextAlignmentCenter;
 lbl_srno.textColor=[UIColor whiteColor];
 lbl_srno.backgroundColor = [UIColor clearColor];
 lbl_srno.text=@"Sr No.";
 [headerView addSubview:lbl_srno];
 UILabel *lbl_username = [[UILabel alloc] initWithFrame:CGRectMake(38,5,128,20)];
 [lbl_username setFont:[UIFont fontWithName:GZFont size:12.0]];
 lbl_username.textColor=[UIColor whiteColor];
 lbl_username.numberOfLines = 0;
 lbl_username.backgroundColor = [UIColor clearColor];
 lbl_username.textAlignment = NSTextAlignmentLeft;
 lbl_username.text=@"Name";
 [headerView addSubview:lbl_username];
 UILabel *lbl_gratuityAmount = [[UILabel alloc] initWithFrame:CGRectMake(160,0,66,40)];
 [lbl_gratuityAmount setFont:[UIFont fontWithName:GZFont size:12.0]];
 lbl_gratuityAmount.textColor=[UIColor whiteColor];
 lbl_gratuityAmount.textAlignment = NSTextAlignmentCenter;
 lbl_gratuityAmount.numberOfLines = 0;
 lbl_gratuityAmount.backgroundColor = [UIColor clearColor];
 lbl_gratuityAmount.text=@"Total Amount";
 lbl_gratuityAmount.lineBreakMode =NSLineBreakByWordWrapping;
 [headerView addSubview:lbl_gratuityAmount];
 UILabel *lbl_detailTitle = [[UILabel alloc] initWithFrame:CGRectMake(229,0,40,40)];
 [lbl_detailTitle setFont:[UIFont fontWithName:GZFont size:11.0]];
 lbl_detailTitle.textAlignment = NSTextAlignmentLeft;
 lbl_detailTitle.textColor=[UIColor whiteColor];
 lbl_detailTitle.numberOfLines = 0;
 lbl_detailTitle.backgroundColor = [UIColor clearColor];
 lbl_detailTitle.text=@"Click For Details";
 lbl_detailTitle.lineBreakMode =NSLineBreakByWordWrapping;
 [headerView addSubview:lbl_detailTitle];
 headerView.backgroundColor =RGB(141, 113, 91);
 
 UIView *horizontalLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 1)];
 horizontalLine.backgroundColor=[UIColor whiteColor];
 [headerView addSubview:horizontalLine];
 
 UIView* hSeparatorview1 = [[UIView alloc] initWithFrame:CGRectMake(36, 0, 1, 40)];
 hSeparatorview1.backgroundColor = [UIColor whiteColor];
 hSeparatorview1.tag = 1;
 [headerView addSubview:hSeparatorview1];
 
 UIView* hSeparatorview5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
 hSeparatorview5.backgroundColor = [UIColor whiteColor];
 hSeparatorview5.tag = 5;
 [headerView addSubview:hSeparatorview5];
 
 UIView* hSeparatorview2 = [[UIView alloc] initWithFrame:CGRectMake(165, 0, 1, 40)];
 hSeparatorview2.backgroundColor = [UIColor whiteColor];
 hSeparatorview2.tag = 2;
 [headerView addSubview:hSeparatorview2];
 UIView* hSeparatorview3 = [[UIView alloc] initWithFrame:CGRectMake(220, 0, 1, 40)];
 hSeparatorview3.backgroundColor = [UIColor whiteColor];
 hSeparatorview3.tag = 3;
 [headerView addSubview:hSeparatorview3];
 UIView* hSeparatorview4 = [[UIView alloc] initWithFrame:CGRectMake(279, 0, 1, 40)];
 hSeparatorview4.backgroundColor = [UIColor whiteColor];
 hSeparatorview4.tag = 4;
 [headerView addSubview:hSeparatorview4];
 
 
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
 NSArray *tempDataArray=[senderHistoryDataArray objectAtIndex:indexPath.row];
 
 SimpleTableIdentifier = @"SimpleTableIdentifier";
 cell = [tableView  dequeueReusableCellWithIdentifier: nil];
 
 if(cell == nil) {
 
 cell = [[UITableViewCell alloc]
 initWithStyle:UITableViewCellStyleDefault
 reuseIdentifier:SimpleTableIdentifier];
 cell.backgroundColor=RGB(210, 200, 191);
 }
 if([senderHistoryDataArray count]==0){
 cell.textLabel.text=@"No Data Found";
 cell.textLabel.font=[UIFont fontWithName:GZFont size:20];
 cell.textLabel.textAlignment=NSTextAlignmentCenter;
 cell.backgroundColor=RGB(210, 200, 191);
 UIView* horizontalview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 1)];
 horizontalview.backgroundColor = [UIColor whiteColor];
 horizontalview.tag = 7;
 [cell addSubview:horizontalview];
 UIView* hSeparatorview5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 50)];
 hSeparatorview5.backgroundColor = [UIColor whiteColor];
 
 hSeparatorview5.tag = 5;
 [cell addSubview:hSeparatorview5];
 UIView* hSeparatorview4 = [[UIView alloc] initWithFrame:CGRectMake(279, 0, 1, 50)];
 hSeparatorview4.backgroundColor = [UIColor whiteColor];
 hSeparatorview4.tag = 4;
 [cell addSubview:hSeparatorview4];
 UIView* horizontalfooterview = [[UIView alloc] initWithFrame:CGRectMake(0, 49, 280, 1)];
 horizontalfooterview.backgroundColor = [UIColor whiteColor];
 
 horizontalfooterview.tag = 8;
 [cell addSubview:horizontalfooterview];
 return cell;
 }
 UILabel *lbl_srno = [[UILabel alloc] initWithFrame:CGRectMake(0,10,33,20)];
 [lbl_srno setFont:[UIFont fontWithName:GZFont size:12.0]];
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
 
 UILabel *lbl_gratuityAmount = [[UILabel alloc] initWithFrame:CGRectMake(180,10,66,20)];
 [lbl_gratuityAmount setFont:[UIFont fontWithName:GZFont size:12.0]];
 lbl_gratuityAmount.textAlignment = NSTextAlignmentLeft;
 lbl_gratuityAmount.numberOfLines = 0;
 lbl_gratuityAmount.backgroundColor = [UIColor clearColor];
 lbl_gratuityAmount.text = [[tempDataArray objectAtIndex:2] stringValue];
 [cell addSubview:lbl_gratuityAmount];
 
 UIButton *previewButton=[UIButton buttonWithType:UIButtonTypeCustom];
 previewButton.frame=CGRectMake(220, 0, 50, 40);
 [previewButton setImage:[UIImage imageNamed:@"details"] forState:UIControlStateNormal];
 [previewButton addTarget:self action:@selector(detailViewAction:) forControlEvents:UIControlEventTouchUpInside];
 [previewButton setTag:indexPath.row];
 [cell addSubview:previewButton];
 
 
 
 
 //create a hoizontal separator in cell to display it like column
 UIView* horizontalview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 1)];
 horizontalview.backgroundColor = [UIColor whiteColor];
 horizontalview.tag = 7;
 [cell addSubview:horizontalview];
 
 UIView* hSeparatorview1 = [[UIView alloc] initWithFrame:CGRectMake(36, 0, 1, 50)];
 hSeparatorview1.backgroundColor = [UIColor whiteColor];
 
 hSeparatorview1.tag = 1;
 [cell addSubview:hSeparatorview1];
 UIView* hSeparatorview5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 50)];
 hSeparatorview5.backgroundColor = [UIColor whiteColor];
 
 hSeparatorview5.tag = 5;
 [cell addSubview:hSeparatorview5];
 
 UIView* hSeparatorview2 = [[UIView alloc] initWithFrame:CGRectMake(165, 0, 1, 50)];
 hSeparatorview2.backgroundColor = [UIColor whiteColor];
 hSeparatorview2.tag = 2;
 [cell addSubview:hSeparatorview2];
 UIView* hSeparatorview3 = [[UIView alloc] initWithFrame:CGRectMake(220, 0, 1, 50)];
 hSeparatorview3.backgroundColor = [UIColor whiteColor];
 hSeparatorview3.tag = 3;
 [cell addSubview:hSeparatorview3];
 UIView* hSeparatorview4 = [[UIView alloc] initWithFrame:CGRectMake(279, 0, 1, 50)];
 hSeparatorview4.backgroundColor = [UIColor whiteColor];
 hSeparatorview4.tag = 4;
 [cell addSubview:hSeparatorview4];
 if(indexPath.row==[senderHistoryDataArray count]-1){
 NSLog(@"last cell");
 UIView* horizontalfooterview = [[UIView alloc] initWithFrame:CGRectMake(0, 49, 280, 1)];
 horizontalfooterview.backgroundColor = [UIColor whiteColor];
 
 horizontalfooterview.tag = 8;
 [cell addSubview:horizontalfooterview];
 }
 
 
 
 
 return cell;
 
 }
 
 //-(IBAction)detailViewAction:(id)sender{
 //
 //    NSLog(@"sender tag:%d",[sender tag]);
 //    NSArray *tempDataArray=[senderHistoryDataArray objectAtIndex:[sender tag]];
 //    NSLog(@"details of:%@",tempDataArray);
 //    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLServiceProviderDetailHistory]];
 //    __unsafe_unretained ASIFormDataRequest *request = _request;
 //    NSDictionary *serviceProviderDetailHistory=[[NSDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"],@"service_providerId",[[tempDataArray objectAtIndex:1] stringValue],@"sender_id", nil];
 //    [request appendPostData:[[NSString stringWithFormat:@"%@",serviceProviderDetailHistory] dataUsingEncoding:NSUTF8StringEncoding]];
 //    NSLog(@"%@",serviceProviderDetailHistory);
 //    [request setCompletionBlock:^{
 //        NSMutableDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
 //        NSLog(@"details history root%@",root);
 //        [self intializeHistoryData:root[@"detailsHistory"] tag:2 completionBlock:^(BOOL result) {
 //
 //            if(result){
 //                historyVC.ischarity=isCharity;
 //                [self.navigationController pushViewController:historyVC animated:YES];
 //            }
 //
 //        }];
 //    }];
 //    [request startAsynchronous];
 //}
 - (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 return 50.0f;
 }
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
