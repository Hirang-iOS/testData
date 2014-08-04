//
//  SenderHistoryViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 31/12/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "SenderHistoryViewController.h"

@interface SenderHistoryViewController ()

@end

@implementation SenderHistoryViewController
HistoryDetailViewController *historyVC;
@synthesize senderHistoryDataArray,sender_table;
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
    self.title=@"History";
    self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];

}

-(void)viewWillAppear:(BOOL)animated{
   
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [senderHistoryDataArray count];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    // This will create a "invisible" footer
//    return 0.01f;
//}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView* horizontalview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 1)];
//    horizontalview.backgroundColor = [UIColor blackColor];
//    return horizontalview;
//
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 40.0f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* headerView = [[UIView alloc]init];
    
    UILabel *lbl_srno = [[UILabel alloc] initWithFrame:CGRectMake(0,5,33,20)];
    [lbl_srno setFont:[UIFont fontWithName:GZFont size:11.0]];
    lbl_srno.numberOfLines = 0;
    lbl_srno.textAlignment = NSTextAlignmentCenter;
    lbl_srno.backgroundColor = [UIColor clearColor];
    lbl_srno.text=@"Sr No.";
    lbl_srno.textColor=[UIColor whiteColor];
    [headerView addSubview:lbl_srno];
    UILabel *lbl_username = [[UILabel alloc] initWithFrame:CGRectMake(38,5,128,20)];
    [lbl_username setFont:[UIFont fontWithName:GZFont size:12.0]];
    lbl_username.numberOfLines = 0;
    lbl_username.backgroundColor = [UIColor clearColor];
    lbl_username.textAlignment = NSTextAlignmentCenter;
    lbl_username.textColor=[UIColor whiteColor];
    lbl_username.text=@"Given To";
    [headerView addSubview:lbl_username];
    UILabel *lbl_gratuityAmount = [[UILabel alloc] initWithFrame:CGRectMake(160,5,66,20)];
    [lbl_gratuityAmount setFont:[UIFont fontWithName:GZFont size:12.0]];
    lbl_gratuityAmount.textAlignment = NSTextAlignmentCenter;
    lbl_gratuityAmount.numberOfLines = 0;
    lbl_gratuityAmount.textColor=[UIColor whiteColor];
    lbl_gratuityAmount.backgroundColor = [UIColor clearColor];
    lbl_gratuityAmount.text=@"Amount";
    [headerView addSubview:lbl_gratuityAmount];
    UILabel *lbl_detailTitle = [[UILabel alloc] initWithFrame:CGRectMake(229,0,40,40)];
    [lbl_detailTitle setFont:[UIFont fontWithName:GZFont size:11.0]];
    lbl_detailTitle.textAlignment = NSTextAlignmentLeft;
    lbl_detailTitle.numberOfLines = 0;
    lbl_detailTitle.textColor=[UIColor whiteColor];
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
  
//    tableView.tableHeaderView=nil;
//   // tableView.tableFooterView=nil;
//    tableView.backgroundColor=RGB(210, 200, 191);
//    [tableView setSeparatorInset:UIEdgeInsetsZero];
//    tableView.contentInset=UIEdgeInsetsZero;
//    NSString *SimpleTableIdentifier;
//    UITableViewCell * cell;
//    
//    NSArray *tempDataArray=[senderHistoryDataArray objectAtIndex:indexPath.row];
//    NSLog(@"table loaded");
//    SimpleTableIdentifier = @"SimpleTableIdentifier";
//    cell = [tableView  dequeueReusableCellWithIdentifier: @"cell"];
//    
//    if(cell == nil) {
//        
//        cell = [[UITableViewCell alloc]
//                initWithStyle:UITableViewCellStyleDefault
//                reuseIdentifier:SimpleTableIdentifier];
//        cell.backgroundColor=RGB(210, 200, 191);
//    
//        
//        if([senderHistoryDataArray count]==0){
//            cell.textLabel.text=@"No Data Found";
//            cell.textLabel.textAlignment=NSTextAlignmentCenter;
//            cell.textLabel.font=[UIFont fontWithName:GZFont size:14];
//            NSLog(@"return");
//            return cell;
//        }
//        UILabel *lbl_srno = [[UILabel alloc] initWithFrame:CGRectMake(0,5,33,20)];
//        [lbl_srno setFont:[UIFont fontWithName:GZFont size:12.0]];
//        lbl_srno.numberOfLines = 0;
//        lbl_srno.textAlignment = NSTextAlignmentCenter;
//        lbl_srno.backgroundColor = [UIColor clearColor];
//        lbl_srno.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
//        
//        [cell addSubview:lbl_srno];
//        
//        UILabel *lbl_username = [[UILabel alloc] initWithFrame:CGRectMake(40,5,128,20)];
//        [lbl_username setFont:[UIFont fontWithName:GZFont size:12.0]];
//        lbl_username.numberOfLines = 0;
//        lbl_username.backgroundColor = [UIColor clearColor];
//        lbl_username.textAlignment = NSTextAlignmentLeft;
//        lbl_username.text =[tempDataArray objectAtIndex:0];
//        [cell addSubview:lbl_username];
//        
//        UILabel *lbl_gratuityAmount = [[UILabel alloc] initWithFrame:CGRectMake(180,5,66,20)];
//        [lbl_gratuityAmount setFont:[UIFont fontWithName:GZFont size:12.0]];
//        lbl_gratuityAmount.textAlignment = NSTextAlignmentLeft;
//        lbl_gratuityAmount.numberOfLines = 0;
//        lbl_gratuityAmount.backgroundColor = [UIColor clearColor];
//        lbl_gratuityAmount.text = [[tempDataArray objectAtIndex:2] stringValue];
//        [cell addSubview:lbl_gratuityAmount];
//        
//        UIButton *previewButton=[UIButton buttonWithType:UIButtonTypeCustom];
//        previewButton.frame=CGRectMake(220, 0, 66, 40);
//        //[previewButton setTitle:@"Details" forState:UIControlStateNormal];
//        //[previewButton setTitleColor:RGB(110, 73, 44) forState:UIControlStateNormal];
//        [previewButton setImage:[UIImage imageNamed:@"details"] forState:UIControlStateNormal];
//        [previewButton addTarget:self action:@selector(detailViewAction:) forControlEvents:UIControlEventTouchUpInside];
//        [previewButton setTag:indexPath.row];
//        [cell addSubview:previewButton];
//       
//       
//        
//       
//        UIView* hSeparatorview1 = [[UIView alloc] initWithFrame:CGRectMake(36, 0, 1, 40)];
//        hSeparatorview1.backgroundColor = [UIColor whiteColor];
//        
//        hSeparatorview1.tag = 1;
//        [cell addSubview:hSeparatorview1];
//        UIView* hSeparatorview5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
//        hSeparatorview5.backgroundColor = [UIColor whiteColor];
//        
//        hSeparatorview5.tag = 5;
//        [cell addSubview:hSeparatorview5];
//        
//        UIView* hSeparatorview2 = [[UIView alloc] initWithFrame:CGRectMake(165, 0, 1, 40)];
//        hSeparatorview2.backgroundColor = [UIColor whiteColor];
//        hSeparatorview2.tag = 2;
//        [cell addSubview:hSeparatorview2];
//        UIView* hSeparatorview3 = [[UIView alloc] initWithFrame:CGRectMake(220, 0, 1, 40)];
//        hSeparatorview3.backgroundColor = [UIColor whiteColor];
//        hSeparatorview3.tag = 3;
//        [cell addSubview:hSeparatorview3];
//        UIView* hSeparatorview4 = [[UIView alloc] initWithFrame:CGRectMake(279, 0, 1, 40)];
//        hSeparatorview4.backgroundColor = [UIColor whiteColor];
//        hSeparatorview4.tag = 4;
//        [cell addSubview:hSeparatorview4];
//      
//            UIView* horizontalfooterview = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 280, 1)];
//            horizontalfooterview.backgroundColor = [UIColor whiteColor];
//            
//            horizontalfooterview.tag = 8;
//            [cell addSubview:horizontalfooterview];
//        
//    }
//    NSLog(@"return");
//    return cell;
    
    tableView.tableHeaderView=nil;
    tableView.contentInset=UIEdgeInsetsZero;
    //  tableView.backgroundColor=RGB(210, 200, 191);
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    NSString *SimpleTableIdentifier;
    UITableViewCell * cell;
    NSArray *tempDataArray=[senderHistoryDataArray objectAtIndex:indexPath.row];
    NSLog(@"tempData %@ count %d",tempDataArray,[senderHistoryDataArray count]);
    SimpleTableIdentifier = @"SimpleTableIdentifier";
    cell = [tableView  dequeueReusableCellWithIdentifier:@"LastTransactionCell"];
    
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SimpleTableIdentifier];
        cell.backgroundColor=RGB(210, 200,191);}
        if([senderHistoryDataArray count]==0){
            cell.textLabel.text=@"No Last Transaction Found";
            cell.textLabel.textAlignment=NSTextAlignmentCenter;
            cell.textLabel.font=[UIFont fontWithName:GZFont size:15];
          
            UIView* horizontalview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 1)];
            horizontalview.backgroundColor = [UIColor whiteColor];
            horizontalview.tag = 7;
            [cell addSubview:horizontalview];
            
            UIView* horizontalfooterview = [[UIView alloc] initWithFrame:CGRectMake(0, 49, 280, 1)];
            horizontalfooterview.backgroundColor = [UIColor whiteColor];
            
            horizontalfooterview.tag = 8;
            [cell addSubview:horizontalfooterview];
            UIView* hSeparatorview5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 50)];
            hSeparatorview5.backgroundColor = [UIColor whiteColor];
            
            hSeparatorview5.tag = 5;
            [cell addSubview:hSeparatorview5];
            UIView* hSeparatorview6 = [[UIView alloc] initWithFrame:CGRectMake(279, 0, 1, 50)];
            hSeparatorview6.backgroundColor = [UIColor whiteColor];
            hSeparatorview6.tag = 6;
            [cell addSubview:hSeparatorview6];
            return cell;
        
        
//        NSLog(@"hello");
//        UILabel *lbl_srno = [[UILabel alloc] initWithFrame:CGRectMake(0,10,33,20)];
//        [lbl_srno setFont:[UIFont fontWithName:GZFont  size:12.0]];
//        lbl_srno.numberOfLines = 0;
//        lbl_srno.textAlignment = NSTextAlignmentCenter;
//        lbl_srno.backgroundColor = [UIColor clearColor];
//        lbl_srno.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
//        
//        [cell addSubview:lbl_srno];
//        
//        UILabel *lbl_username = [[UILabel alloc] initWithFrame:CGRectMake(40,14,128,20)];
//        [lbl_username setFont:[UIFont fontWithName:GZFont size:12.0]];
//        lbl_username.numberOfLines = 0;
//        lbl_username.lineBreakMode=NSLineBreakByWordWrapping;
//        lbl_username.backgroundColor = [UIColor clearColor];
//        lbl_username.textAlignment = NSTextAlignmentLeft;
//        lbl_username.text =[tempDataArray objectAtIndex:0];
//        [lbl_username sizeToFit];
//        [cell addSubview:lbl_username];
//        if(ischarity==TRUE){
//            UILabel *lbl_gratuityAmount = [[UILabel alloc] initWithFrame:CGRectMake(126,10,66,20)];
//            [lbl_gratuityAmount setFont:[UIFont fontWithName:GZFont size:12.0]];
//            lbl_gratuityAmount.textAlignment = NSTextAlignmentCenter;
//            lbl_gratuityAmount.numberOfLines = 0;
//            lbl_gratuityAmount.backgroundColor = [UIColor clearColor];
//            lbl_gratuityAmount.text = [[tempDataArray objectAtIndex:1] stringValue];
//            [cell addSubview:lbl_gratuityAmount];
//        }
//        else{
//            UILabel *lbl_gratuityAmount = [[UILabel alloc] initWithFrame:CGRectMake(132,10,66,20)];
//            [lbl_gratuityAmount setFont:[UIFont fontWithName:GZFont size:12.0]];
//            lbl_gratuityAmount.textAlignment = NSTextAlignmentCenter;
//            lbl_gratuityAmount.numberOfLines = 0;
//            lbl_gratuityAmount.backgroundColor = [UIColor clearColor];
//            lbl_gratuityAmount.text = [[tempDataArray objectAtIndex:1] stringValue];
//            [cell addSubview:lbl_gratuityAmount];
//        }
//        if(ischarity==TRUE){
//            UILabel *lbl_receivedTitle = [[UILabel alloc] initWithFrame:CGRectMake(190,0,40,40)];
//            [lbl_receivedTitle setFont:[UIFont fontWithName:GZFont size:12.0]];
//            lbl_receivedTitle.textAlignment = NSTextAlignmentCenter;
//            lbl_receivedTitle.numberOfLines = 0;
//            lbl_receivedTitle.backgroundColor = [UIColor clearColor];
//            lbl_receivedTitle.text=[[tempDataArray objectAtIndex:2] stringValue];
//            lbl_receivedTitle.lineBreakMode =NSLineBreakByWordWrapping;
//            [cell addSubview:lbl_receivedTitle];
//        }
//        else{
//            UILabel *lbl_receivedTitle = [[UILabel alloc] initWithFrame:CGRectMake(220,0,40,40)];
//            [lbl_receivedTitle setFont:[UIFont fontWithName:GZFont size:12.0]];
//            lbl_receivedTitle.textAlignment = NSTextAlignmentCenter;
//            lbl_receivedTitle.numberOfLines = 0;
//            lbl_receivedTitle.backgroundColor = [UIColor clearColor];
//            lbl_receivedTitle.text=[[tempDataArray objectAtIndex:2] stringValue];
//            lbl_receivedTitle.lineBreakMode =NSLineBreakByWordWrapping;
//            [cell addSubview:lbl_receivedTitle];
//        }
//        if(ischarity==TRUE){
//            
//            
//            UILabel *lbl_donatedTitle = [[UILabel alloc] initWithFrame:CGRectMake(246,0,40,40)];
//            [lbl_donatedTitle setFont:[UIFont fontWithName:GZFont  size:12.0]];
//            lbl_donatedTitle.textAlignment = NSTextAlignmentCenter;
//            lbl_donatedTitle.numberOfLines = 0;
//            lbl_donatedTitle.backgroundColor = [UIColor clearColor];
//            lbl_donatedTitle.text=[[tempDataArray objectAtIndex:3] stringValue];
//            lbl_donatedTitle.lineBreakMode =NSLineBreakByWordWrapping;
//            [cell addSubview:lbl_donatedTitle];
//        }
//        
//        
//        
//        //create a hoizontal separator in cell to display it like column
//        UIView* horizontalview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 1)];
//        horizontalview.backgroundColor = [UIColor whiteColor];
//        
//        horizontalview.tag = 7;
//        [cell addSubview:horizontalview];
//        UIView* hSeparatorview1 = [[UIView alloc] initWithFrame:CGRectMake(36, 0, 1, 50)];
//        hSeparatorview1.backgroundColor = [UIColor whiteColor];
//        
//        hSeparatorview1.tag = 1;
//        [cell addSubview:hSeparatorview1];
//        UIView* hSeparatorview5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 50)];
//        hSeparatorview5.backgroundColor = [UIColor whiteColor];
//        
//        hSeparatorview5.tag = 5;
//        [cell addSubview:hSeparatorview5];
//        
//        UIView* hSeparatorview2 = [[UIView alloc] initWithFrame:CGRectMake(138, 0, 1, 50)];
//        hSeparatorview2.backgroundColor = [UIColor whiteColor];
//        hSeparatorview2.tag = 2;
//        [cell addSubview:hSeparatorview2];
//        if(ischarity==TRUE){
//            UIView* hSeparatorview3 = [[UIView alloc] initWithFrame:CGRectMake(184, 0, 1, 50)];
//            hSeparatorview3.backgroundColor = [UIColor whiteColor];
//            hSeparatorview3.tag = 3;
//            [cell addSubview:hSeparatorview3];
//        }
//        else{
//            UIView* hSeparatorview3 = [[UIView alloc] initWithFrame:CGRectMake(200, 0, 1, 50)];
//            hSeparatorview3.backgroundColor = [UIColor whiteColor];
//            hSeparatorview3.tag = 3;
//            [cell addSubview:hSeparatorview3];
//        }
//        if(ischarity==TRUE){
//            UIView* hSeparatorview4 = [[UIView alloc] initWithFrame:CGRectMake(240, 0, 1, 50)];
//            hSeparatorview4.backgroundColor = [UIColor whiteColor];
//            hSeparatorview4.tag = 4;
//            [cell addSubview:hSeparatorview4];
//        }
//        UIView* hSeparatorview6 = [[UIView alloc] initWithFrame:CGRectMake(300, 0, 1, 50)];
//        hSeparatorview6.backgroundColor = [UIColor whiteColor];
//        hSeparatorview6.tag = 6;
//        [cell addSubview:hSeparatorview6];
//        if(indexPath.row==[SPLastTransactionDataArray count]-1){
//            NSLog(@"last cell");
//            UIView* horizontalfooterview = [[UIView alloc] initWithFrame:CGRectMake(0, 49, 300, 1)];
//            horizontalfooterview.backgroundColor = [UIColor whiteColor];
//            
//            horizontalfooterview.tag = 8;
//            [cell addSubview:horizontalfooterview];
//        }
        
    }
    
    return cell;
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
    return 50.0f;
}

-(void)initializeSenderHistoryArray:(NSMutableArray *)ary completionBlock:(void (^)(BOOL result)) return_block{
    historyVC.detailHistoryDataArray=ary;
    return_block(TRUE);
    
}

@end
