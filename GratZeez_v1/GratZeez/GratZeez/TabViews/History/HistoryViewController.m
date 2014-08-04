//
//  HistoryViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 14/10/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "HistoryViewController.h"

#import "SearchedResultViewController.h"
#import "InviteFriendsViewController.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

//@synthesize receiverArray;
//@synthesize filteredReceiverArray;
//@synthesize gratuityReceiverSearchBar;

@synthesize txtSearchUsername,txtSearchNumber,txtSearchEstablishment,searchLbl,btn_Favorite,btn_inviteUser,btn_locateNearBy,btn_scanBarCode,headingLbl,ServiceProviderView,historyTable,SenderView,historyVC,lbl_titleHistory,mainToolBar;

float srLbl_width=40;
float nameLbl_width=90;
float totalAmountLbl_width=46;
float receivedAmountLbl_width=50;
float donatedAmountLbl_width=65;
BOOL fromReturn;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    NSString *nibName;
    if(MyAppDelegate.isIpad){
        nibName=@"HistoryViewControllerIpad";
    }
    else if (MyAppDelegate.isiPhone5){
        nibName=@"HistoryViewController";
    }
    else{
        nibName=@"HistoryViewController4s";
    }
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //lbl.font=[UIFont fontWithName:@"Al" size:20];
    //lbl.text=@"Option";
    
    NSLog(@"%f %f",self.view.frame.origin.y,self.view.frame.size.height);
    
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    
    //self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    [self addLeftMenuButtonWithImage:[UIImage imageNamed:@"menu_icon"]];
    [self addrightMenuButtonWithImage:[UIImage imageNamed:@"help"]];
    
}

-(void)viewWillAppear:(BOOL)animated{
    NSLog(@"up tp view");
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"LoginAs"] isEqual:ServiceProvider]){
     //   [[MyAppDelegate.tabBar.tabBar.items objectAtIndex:1] setTitle:@"History"];
        self.title = @"History";
        self.view=self.ServiceProviderView;
        lbl_titleHistory.font=[UIFont fontWithName:GZFont size:18];
         self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
        ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLServiceProviderHistory]];
        __unsafe_unretained ASIFormDataRequest *request = _request;
        NSDictionary *serviceProviderHistory=[[NSDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"],@"service_providerId", nil];
        [request appendPostData:[[NSString stringWithFormat:@"%@",serviceProviderHistory] dataUsingEncoding:NSUTF8StringEncoding]];
        NSLog(@"%@",serviceProviderHistory);
        [request setCompletionBlock:^{
            NSMutableDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
            NSLog(@"ServicProviderHistory Root %@",root);
            historyDataArray=root[@"totalGratuity"];
            
            if ([root[@"CharityTotalAmount"] integerValue]!=0) {
                NSLog(@"with 10");
                isCharity=TRUE;
                [self intializeHistoryData:root[@"totalGratuity"] tag:1 completionBlock:^(BOOL result) {
                    if(result){
                        CGRect frameTable;
                        float height;
                        frameTable=historyTable.frame;
                        frameTable.size.width=318;
                        frameTable.origin.x=1;
                        if([historyDataArray count]==0){
                            height=100;
                        }else{
                        height = [historyDataArray count] * 40 +40 ; // 4*25.00
                        }
                        NSLog(@"height of table: %f",height);
                        frameTable.size.height=height;
                        historyTable.frame=frameTable;
                
                        [historyTable reloadData];
                    }
                }];
            }
            else{
                NSLog(@"with 0");
                isCharity=FALSE;
                [self intializeHistoryData:root[@"totalGratuity"] tag:1 completionBlock:^(BOOL result) {
                    if(result){
                        CGRect frameTable;
                        float height;
                        frameTable=historyTable.frame;
                        frameTable.size.width=280;
                        frameTable.origin.x=20;
                        if([historyDataArray count]==0){
                            height=90;
                        }else{
                        height = [historyDataArray count] * 40 +40 ;
                        }
                        NSLog(@"height of table: %f",height);
                        if(height>=330){
                            frameTable.size.height=329;
                        }
                        else{
                            frameTable.size.height=height;
                        }
                        
                        historyTable.frame=frameTable;

                        [historyTable reloadData];
                    }
                }];
            }

            
        }];
        [request startAsynchronous];
        historyVC=[[HistoryDetailViewController alloc]initWithNibName:@"HistoryDetailViewController" bundle:nil];
       
    }
    else{
        NSLog(@"reachto view");
        //NSString *str=[NSString stringWithUTF8String:[[[NSUserDefaults standardUserDefaults] valueForKey:@"card.io - PayPal_MPL_Previous_AuthMethod"] bytes]];
        //[[MyAppDelegate.tabBar.tabBar.items objectAtIndex:1] setTitle:@"Search"];
        self.title = @"Search";
        //self.view.hidden=NO;
        self.view=self.SenderView;
        [self.view setUserInteractionEnabled:YES];
        self.view.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
        searchLbl.font=[UIFont fontWithName:GZFont size:18.0f];
        headingLbl.font=[UIFont fontWithName:@"Garamond 3 SC" size:20.0f];
        NSMutableAttributedString *gpsSearch = [[NSMutableAttributedString alloc] initWithString:@"GPS Search"];
        [gpsSearch addAttribute:(NSString*)kCTUnderlineStyleAttributeName
                          value:[NSNumber numberWithInt:NSUnderlineStyleSingle]
                          range:(NSRange){0,[gpsSearch length]}];
        self.headingLbl.attributedText = gpsSearch;
        self.headingLbl.textColor = [UIColor blackColor];
        btn_Favorite.titleLabel.font=[UIFont fontWithName:GZFont size:18.0f];
        btn_inviteUser.titleLabel.font=[UIFont fontWithName:GZFont size:18.0f];
        btn_locateNearBy.titleLabel.font=[UIFont fontWithName:GZFont size:18.0f];
        btn_scanBarCode.titleLabel.font=[UIFont fontWithName:GZFont size:18.0f];
        txtSearchUsername.font=[UIFont fontWithName:GZFont size:15.0f];
        txtSearchEstablishment.font=[UIFont fontWithName:GZFont size:15.0f];
    }
    mainToolBar.frame=CGRectMake(0, 524, 320, 44);
    
//    else{
//        mainToolBar.frame=CGRectMake(0,436, 320, 44);
//    }
    [self.view addSubview:mainToolBar];
    NSLog(@"up tp view");
    [mainToolBar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    
}
-(void)viewDidAppear:(BOOL)animated{

    NSLog(@"===>%f %f",self.view.frame.origin.y,self.view.frame.size.height);
}
-(void)viewWillDisappear:(BOOL)animated{
    [txtSearchUsername resignFirstResponder];
    [txtSearchEstablishment resignFirstResponder];
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

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [txtSearchUsername resignFirstResponder];
   // [txtSearchNumber resignFirstResponder];
    [txtSearchEstablishment resignFirstResponder];
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        NSLog(@"frame==> %f %f",self.view.frame.size.height,self.view.frame.origin.y);
        self.view.frame=CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
    } completion:^(BOOL finished){
        if(finished){
            NSLog(@"finished");
        }
    }];
    
}

- (IBAction)btnNearbyUserAction:(id)sender {
    GpsSearchViewController *gpsSearch=[[GpsSearchViewController alloc]init];
    [self.navigationController pushViewController:gpsSearch animated:YES];
    
}
- (IBAction)btnScaneBarcodeAction:(id)sender {
    [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                    type:AJNotificationTypeBlue
                                   title:@"Coming Soon"
                         linedBackground:AJLinedBackgroundTypeDisabled
                               hideAfter:GZAJNotificationDelay];
}
- (IBAction)btnInviteNewUserAction:(id)sender {
    InviteFriendsViewController *InviteFriendVC = [[InviteFriendsViewController alloc] initWithNibName:@"InviteFriendsViewController" bundle:nil];
    [self.navigationController pushViewController:InviteFriendVC animated:YES];
}
- (IBAction)btnSearchAction:(id)sender {
   if([[txtSearchUsername.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]<=0 &&
       [[txtSearchNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]<=0 && [[txtSearchEstablishment.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]<=0) {
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:@"Please Enter SearchData"
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return ;
    }
    
    NSMutableArray *objects=[[NSMutableArray alloc]init];
    NSMutableArray *keys=[[NSMutableArray alloc]init];
    if([[txtSearchUsername.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]>0){
        [objects addObject:[txtSearchUsername.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
        [keys addObject:@"user_name"];
        txtSearchUsername.text=nil;
    }
//    if([txtSearchNumber.text length]>0){
//        [objects addObject:[txtSearchNumber.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
//        [keys addObject:@"gz_number"];
//        txtSearchNumber.text=nil;
//    }
    if([txtSearchEstablishment.text length]>0){
        [objects addObject:[txtSearchEstablishment.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
        [keys addObject:@"e_name"];
        txtSearchEstablishment.text=nil;
    }
    [objects addObject:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"]];
    [keys addObject:@"sender_id"];
    NSDictionary *searchDictionary=[[NSDictionary alloc]initWithObjects:objects forKeys:keys];
    NSLog(@"%@",searchDictionary);
    SearchedResultViewController *SearchResultVC = [[SearchedResultViewController alloc] initWithNibName:@"SearchedResultViewController" bundle:nil];
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLAdvanceSearch]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    
    [request appendPostData:[[NSString stringWithFormat:@"%@",searchDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setCompletionBlock:^{
        NSMutableDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
        NSLog(@"Searh root%@",root);
        if([[root valueForKey:@"isError"] boolValue]==0){
            //MyAppDelegate.searchResultArray=[root valueForKey:@"searchResult"];
            MyAppDelegate.searchResultArray=[[NSMutableArray alloc]init];
            [self compute:[root valueForKey:@"searchResult"] completionBlock:^(BOOL result){
                if(result){
                NSLog(@"after co");
                [self.navigationController pushViewController:SearchResultVC animated:YES];
                }
            }];
            
        }
               else{
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window type:AJNotificationTypeRed
                                       title:[root objectForKey:@"message"]
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
            return ;
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

  //  [self.navigationController pushViewController:SearchResultVC animated:YES];
}

//To avoid redundancy of same data with just only place name different Implement this method to concate place of same data.
-(void)compute:(NSMutableArray *)ary completionBlock:(void (^)(BOOL result)) return_block{
    NSLog(@"before co");
    int id=0;
    NSLog(@"Array is%@",ary);
    NSMutableArray *temp;
    for(int i=0;i<[ary count];i++){
        temp=[ary objectAtIndex:i];
            NSLog(@"string%@",[temp objectAtIndex:9]);
        if(id==[[temp objectAtIndex:4] integerValue]){
            NSLog(@"inside");
            NSMutableArray *temp1=[[MyAppDelegate.searchResultArray lastObject] mutableCopy];
            NSLog(@"temp1%@",temp1);
            NSString *tempStr=[NSString stringWithFormat:@"%@,%@",[temp1 objectAtIndex:9],[temp objectAtIndex:9]];
            NSLog(@"%@",tempStr);
             NSString *Id_Str=[NSString stringWithFormat:@"%@,%@",[temp1 objectAtIndex:8],[temp objectAtIndex:8]];
            [temp1 replaceObjectAtIndex:9 withObject:tempStr];
            [temp1 replaceObjectAtIndex:8 withObject:Id_Str];
            [MyAppDelegate.searchResultArray replaceObjectAtIndex:[MyAppDelegate.searchResultArray count]-1 withObject:temp1];
        }
        else{
        
        NSLog(@"temp is%@ %d",temp,id);
        [MyAppDelegate.searchResultArray addObject:temp];
        }
        id=[[temp objectAtIndex:4] integerValue];
   }
   NSLog(@"%@",MyAppDelegate.searchResultArray);
    return_block(TRUE);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField==txtSearchUsername) {
        fromReturn=1;
        [txtSearchUsername resignFirstResponder];
        [txtSearchEstablishment becomeFirstResponder];
    }
    else if (textField==txtSearchEstablishment) {
        [txtSearchEstablishment resignFirstResponder];
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            NSLog(@"frame==> %f %f",self.view.frame.size.height,self.view.frame.origin.y);
            self.view.frame=CGRectMake(0,0,self.view.frame.size.width,self.view.frame.size.height);
        } completion:^(BOOL finished){
            if(finished){
                NSLog(@"finished");
            }
        }];
    }
    return YES;
}


- (IBAction)myFavoriteAction:(id)sender {
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLMyFavorite]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    NSDictionary *favoriteListDictionary =[[NSDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"],@"sender_id",@"YES",@"request_for_favoriteList", nil];
    [request appendPostData:[[NSString stringWithFormat:@"%@",favoriteListDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setCompletionBlock:^{
        NSMutableDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
        NSLog(@"Searh root%@",root);
        if([[root valueForKey:@"isError"] boolValue]==0){
            MyAppDelegate.searchResultArray=[[NSMutableArray alloc]init];
            [root valueForKey:@"search-Result"];
            MyFavoriteListViewController *MFVC=[[MyFavoriteListViewController alloc]initWithNibName:@"MyFavoriteListViewController" bundle:nil];
            [self compute:[root valueForKey:@"search-Result"] completionBlock:^(BOOL result){
                if(result){
                    NSLog(@"after co");
                    [self.navigationController pushViewController:MFVC animated:YES];
                }
            }];
            
        }
        else{
            [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window type:AJNotificationTypeRed
                                           title:[root objectForKey:@"message"]
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
            
            return ;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)intializeHistoryData:(NSMutableArray *)array tag:(int )tag completionBlock:(void (^)(BOOL result)) return_block{
    if(tag==1){
    historyDataArray=array;
    return_block(TRUE);
    }
    else if(tag==2){
        historyVC.detailHistoryDataArray=array;
        return_block(TRUE);
    }
}

#pragma mark- Methods For receiver

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    //return [SPLastTransactionDataArray count];
    if([historyDataArray count]==0){
        NSLog(@"return 0");
                return 1;
            }
    else
    {
        NSLog(@"return counr %d",[historyDataArray count]);
    return [historyDataArray count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    // This will create a "invisible" footer
    if(isCharity==TRUE){
        NSLog(@"returned 50");
        return 40.0f;
    }
    else{
        NSLog(@"returned 40");
        return 40.0f;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
        UIView* headerView = [[UIView alloc]init];
        if(isCharity==FALSE){
            UILabel *lbl_srno = [[UILabel alloc] initWithFrame:CGRectMake(1,22,40,16)];
            [lbl_srno setFont:[UIFont fontWithName:GZFont size:14]];
            lbl_srno.numberOfLines = 0;
            lbl_srno.textAlignment = NSTextAlignmentLeft;
            lbl_srno.textColor=[UIColor whiteColor];
            lbl_srno.backgroundColor = [UIColor clearColor];
            lbl_srno.text=@"Sr No";
            [headerView addSubview:lbl_srno];
            UILabel *lbl_username = [[UILabel alloc] initWithFrame:CGRectMake(42,22,40,16)];
            [lbl_username setFont:[UIFont fontWithName:GZFont size:14]];
            lbl_username.textColor=[UIColor whiteColor];
            lbl_username.numberOfLines = 0;
            lbl_username.backgroundColor = [UIColor clearColor];
            lbl_username.textAlignment = NSTextAlignmentLeft;
            lbl_username.text=@"Name";
            [headerView addSubview:lbl_username];
            UILabel *lbl_gratuityAmount = [[UILabel alloc] initWithFrame:CGRectMake(170,20,120,20)];
            [lbl_gratuityAmount setFont:[UIFont fontWithName:GZFont size:14.0]];
            lbl_gratuityAmount.textColor=[UIColor whiteColor];
            lbl_gratuityAmount.textAlignment = NSTextAlignmentLeft;
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
            lbl_detailTitle.text=@"";
            lbl_detailTitle.lineBreakMode =NSLineBreakByWordWrapping;
          //  [headerView addSubview:lbl_detailTitle];
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
         //   [headerView addSubview:hSeparatorview3];
            UIView* hSeparatorview4 = [[UIView alloc] initWithFrame:CGRectMake(279, 0, 1, 40)];
            hSeparatorview4.backgroundColor = [UIColor whiteColor];
            hSeparatorview4.tag = 4;
            [headerView addSubview:hSeparatorview4];
        }
        else{
//        srLbl_width=32;
//        nameLbl_width=90;
//        totalAmountLbl_width=46;
//        receivedAmountLbl_width=46;
//        donatedAmountLbl_width=42;
        UILabel *lbl_srno = [[UILabel alloc] initWithFrame:CGRectMake(0,20,srLbl_width,20)];
        [lbl_srno setFont:[UIFont fontWithName:GZFont size:14.0]];
        lbl_srno.numberOfLines = 0;
        lbl_srno.textColor=[UIColor whiteColor];
        lbl_srno.textAlignment = NSTextAlignmentLeft;
        lbl_srno.backgroundColor = [UIColor clearColor];
        lbl_srno.text=@"Sr No.";
        [headerView addSubview:lbl_srno];
        UILabel *lbl_username = [[UILabel alloc] initWithFrame:CGRectMake(srLbl_width+2,20,nameLbl_width,20)];
        [lbl_username setFont:[UIFont fontWithName:GZFont size:14.0]];
        lbl_username.numberOfLines = 0;
        lbl_username.textColor=[UIColor whiteColor];
        lbl_username.backgroundColor = [UIColor clearColor];
        lbl_username.textAlignment = NSTextAlignmentLeft;
        lbl_username.text=@"Name";
        [headerView addSubview:lbl_username];
        UILabel *lbl_gratuityAmount = [[UILabel alloc] initWithFrame:CGRectMake(srLbl_width+nameLbl_width+4,3,totalAmountLbl_width,40)];
        [lbl_gratuityAmount setFont:[UIFont fontWithName:GZFont size:13.0]];
        lbl_gratuityAmount.textAlignment = NSTextAlignmentLeft;
        lbl_gratuityAmount.textColor=[UIColor whiteColor];
        lbl_gratuityAmount.numberOfLines = 0;
        lbl_gratuityAmount.backgroundColor = [UIColor clearColor];
        lbl_gratuityAmount.text=@"Total Amount";
        lbl_gratuityAmount.lineBreakMode =NSLineBreakByWordWrapping;
        [headerView addSubview:lbl_gratuityAmount];
        UILabel *lbl_received = [[UILabel alloc] initWithFrame:CGRectMake(srLbl_width+nameLbl_width+totalAmountLbl_width+6,0,receivedAmountLbl_width,44)];
        [lbl_received setFont:[UIFont fontWithName:GZFont size:13]];
        lbl_received.textColor=[UIColor whiteColor];
        lbl_received.textAlignment = NSTextAlignmentLeft;
        lbl_received.numberOfLines = 0;
        lbl_received.backgroundColor = [UIColor clearColor];
        lbl_received.text=@"Amount Received";
        lbl_received.lineBreakMode =NSLineBreakByWordWrapping;
        [headerView addSubview:lbl_received];
        UILabel *lbl_donated = [[UILabel alloc] initWithFrame:CGRectMake(srLbl_width+nameLbl_width+totalAmountLbl_width+receivedAmountLbl_width+8,2,donatedAmountLbl_width,40)];
        [lbl_donated setFont:[UIFont fontWithName:GZFont size:13.0]];
        lbl_donated.textColor=[UIColor whiteColor];
        lbl_donated.textAlignment = NSTextAlignmentLeft;
        lbl_donated.numberOfLines = 0;
        lbl_donated.backgroundColor = [UIColor clearColor];
        lbl_donated.text=@"Donated To Charity";
        lbl_donated.lineBreakMode =NSLineBreakByWordWrapping;
        [headerView addSubview:lbl_donated];
        UILabel *lbl_detailTitle = [[UILabel alloc] initWithFrame:CGRectMake(srLbl_width+nameLbl_width+totalAmountLbl_width+receivedAmountLbl_width+donatedAmountLbl_width+14,0,40,40)];
        [lbl_detailTitle setFont:[UIFont fontWithName:GZFont size:11.0]];
        lbl_detailTitle.textColor=[UIColor whiteColor];
        lbl_detailTitle.textAlignment = NSTextAlignmentLeft;
        lbl_detailTitle.numberOfLines = 0;
        lbl_detailTitle.backgroundColor = [UIColor clearColor];
        lbl_detailTitle.text=@"";
        lbl_detailTitle.lineBreakMode =NSLineBreakByWordWrapping;
    //    [headerView addSubview:lbl_detailTitle];
        headerView.backgroundColor =RGB(141, 113, 91);
        
        UIView *horizontalLine=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 318, 1)];
        horizontalLine.backgroundColor=[UIColor whiteColor];
        [headerView addSubview:horizontalLine];
        
        UIView* hSeparatorview1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 50)];
        hSeparatorview1.backgroundColor = [UIColor whiteColor];
        hSeparatorview1.tag = 1;
        [headerView addSubview:hSeparatorview1];
        
        UIView* hSeparatorview2 = [[UIView alloc] initWithFrame:CGRectMake(srLbl_width+1, 0, 1, 50)];
        hSeparatorview2.backgroundColor = [UIColor whiteColor];
        hSeparatorview2.tag = 2;
        [headerView addSubview:hSeparatorview2];
        
        UIView* hSeparatorview3 = [[UIView alloc] initWithFrame:CGRectMake(srLbl_width+nameLbl_width+2, 0, 1, 50)];
        hSeparatorview3.backgroundColor = [UIColor whiteColor];
        hSeparatorview3.tag = 3;
        [headerView addSubview:hSeparatorview3];
        
        UIView* hSeparatorview4 = [[UIView alloc] initWithFrame:CGRectMake(srLbl_width+nameLbl_width+totalAmountLbl_width+3, 0, 1, 50)];
        hSeparatorview4.backgroundColor = [UIColor whiteColor];
        hSeparatorview4.tag = 4;
        [headerView addSubview:hSeparatorview4];
        
        UIView* hSeparatorview5 = [[UIView alloc] initWithFrame:CGRectMake(srLbl_width+nameLbl_width+totalAmountLbl_width+receivedAmountLbl_width+5, 0, 1, 50)];
        hSeparatorview5.backgroundColor = [UIColor whiteColor];
        hSeparatorview5.tag = 5;
        [headerView addSubview:hSeparatorview5];
        
        UIView* hSeparatorview6 = [[UIView alloc] initWithFrame:CGRectMake(srLbl_width+nameLbl_width+totalAmountLbl_width+receivedAmountLbl_width+donatedAmountLbl_width+9, 0, 1, 50)];
        hSeparatorview6.backgroundColor = [UIColor whiteColor];
        hSeparatorview6.tag = 6;
       // [headerView addSubview:hSeparatorview6];
        
        UIView* hSeparatorview7 = [[UIView alloc] initWithFrame:CGRectMake(317, 0, 1, 50)];
        hSeparatorview7.backgroundColor = [UIColor whiteColor];
        hSeparatorview7.tag = 7;
        [headerView addSubview:hSeparatorview7];
        
    }
        return headerView;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if(self.view.frame.origin.y==-50){
        return;
    }
    if(textField==txtSearchUsername){
        if(self.view.frame.origin.y!=-50){
        [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            NSLog(@"frame==> %f %f",self.view.frame.size.height,self.view.frame.origin.y);
            self.view.frame=CGRectMake(0,-50,320,self.view.frame.size.height);
        } completion:^(BOOL finished){
            if(finished){
                NSLog(@"finished");
            }
        }];
        }
    }
    
    else if (textField==txtSearchEstablishment) {
        if(self.view.frame.origin.y!=-50){
            [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                
                self.view.frame=CGRectMake(0,-50,320,self.view.frame.size.height);
            } completion:^(BOOL finished){
                if(finished){
                    NSLog(@"finished");
                    
                }
            }];
        }
    }
}
- (void)textFieldDidEndEditing:(UITextField *)textField{

//    if (textField==txtSearchEstablishment) {
//        if(txtSearchUsername.isFirstResponder){
//            return;
//        }
//        else{
//            [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//                
//                self.view.frame=CGRectMake(0,0,320,self.view.frame.size.height);
//            } completion:^(BOOL finished){
//                if(finished){
//                    NSLog(@"finished");
//                    fromReturn=0;
//                    
//                }
//            }];
//        }
//        
//        
//    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    tableView.tableHeaderView=nil;
    tableView.contentInset=UIEdgeInsetsZero;
    tableView.backgroundColor=[UIColor clearColor];
    [tableView setSeparatorInset:UIEdgeInsetsZero];
    NSString *SimpleTableIdentifier;
    UITableViewCell * cell;
    NSArray *tempDataArray=[historyDataArray objectAtIndex:indexPath.row];
    
    SimpleTableIdentifier = @"SimpleTableIdentifier";
    cell = [tableView  dequeueReusableCellWithIdentifier: nil];
    
    if(cell == nil) {
        
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:SimpleTableIdentifier];
        cell.backgroundColor=RGB(210, 200, 191);
    }
        if([historyDataArray count]==0){
            cell.textLabel.text=@"No Data Found";
            cell.textLabel.font=[UIFont fontWithName:GZFont size:20];
            cell.textLabel.textAlignment=NSTextAlignmentCenter;
            cell.backgroundColor=RGB(210, 200, 191);
            UIView* horizontalview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 1)];
            horizontalview.backgroundColor = [UIColor whiteColor];
            horizontalview.tag = 7;
            [cell addSubview:horizontalview];
            UIView* hSeparatorview5 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 40)];
            hSeparatorview5.backgroundColor = [UIColor whiteColor];
            
            hSeparatorview5.tag = 5;
            [cell addSubview:hSeparatorview5];
            UIView* hSeparatorview4 = [[UIView alloc] initWithFrame:CGRectMake(279, 0, 1, 40)];
            hSeparatorview4.backgroundColor = [UIColor whiteColor];
            hSeparatorview4.tag = 4;
            [cell addSubview:hSeparatorview4];
            UIView* horizontalfooterview = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 280, 1)];
            horizontalfooterview.backgroundColor = [UIColor whiteColor];
            
            horizontalfooterview.tag = 8;
            [cell addSubview:horizontalfooterview];
            return cell;
        }
        if(isCharity==FALSE){
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
        previewButton.frame=CGRectMake(220, 3, 50, 40);
        [previewButton setImage:[UIImage imageNamed:@"details"] forState:UIControlStateNormal];
        [previewButton addTarget:self action:@selector(detailViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [previewButton setTag:indexPath.row];
        [cell addSubview:previewButton];
            
        //        UILabel * acardNameLbl3 = [[UILabel alloc] initWithFrame:CGRectMake(133,5,66,20)];
//        acardNameLbl3.text = @"john";
//        [acardNameLbl3 setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
//        //        acardNameLbl3.layer.borderWidth=1.0;
//        //        acardNameLbl3.layer.borderColor=[[UIColor grayColor]CGColor];
//        //        [acardNameLbl3.layer setMasksToBounds:NO];
//        acardNameLbl3.textAlignment = NSTextAlignmentCenter;
//        acardNameLbl3.numberOfLines = 0;
//        acardNameLbl3.backgroundColor = [UIColor clearColor];
//        [cell addSubview:acardNameLbl3];
        
        
        //create a hoizontal separator in cell to display it like column
        UIView* horizontalview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 1)];
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
        
        UIView* hSeparatorview2 = [[UIView alloc] initWithFrame:CGRectMake(165, 0, 1, 40)];
        hSeparatorview2.backgroundColor = [UIColor whiteColor];
        hSeparatorview2.tag = 2;
        [cell addSubview:hSeparatorview2];
        UIView* hSeparatorview3 = [[UIView alloc] initWithFrame:CGRectMake(220, 0, 1, 40)];
        hSeparatorview3.backgroundColor = [UIColor whiteColor];
        hSeparatorview3.tag = 3;
      //  [cell addSubview:hSeparatorview3];
        UIView* hSeparatorview4 = [[UIView alloc] initWithFrame:CGRectMake(279, 0, 1, 40)];
        hSeparatorview4.backgroundColor = [UIColor whiteColor];
        hSeparatorview4.tag = 4;
        [cell addSubview:hSeparatorview4];
        if(indexPath.row==[historyDataArray count]-1){
            NSLog(@"last cell");
            UIView* horizontalfooterview = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 280, 1)];
            horizontalfooterview.backgroundColor = [UIColor whiteColor];
            
            horizontalfooterview.tag = 8;
            [cell addSubview:horizontalfooterview];
        }

    }
    
    else{
//        srLbl_width=32;
//        nameLbl_width=90;
//        totalAmountLbl_width=46;
//        receivedAmountLbl_width=46;
//        donatedAmountLbl_width=42;
        
        UILabel *lbl_srno = [[UILabel alloc] initWithFrame:CGRectMake(0,10,srLbl_width,20)];
        [lbl_srno setFont:[UIFont fontWithName:GZFont size:11.0]];
        lbl_srno.numberOfLines = 0;
        lbl_srno.textAlignment = NSTextAlignmentCenter;
        lbl_srno.backgroundColor = [UIColor clearColor];
        lbl_srno.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
        
        [cell addSubview:lbl_srno];
        
        UILabel *lbl_username = [[UILabel alloc] initWithFrame:CGRectMake(srLbl_width+5,15,nameLbl_width,40)];
        [lbl_username setFont:[UIFont fontWithName:GZFont size:11.0]];
        lbl_username.numberOfLines = 0;
        lbl_username.lineBreakMode=NSLineBreakByWordWrapping;
        lbl_username.backgroundColor = [UIColor clearColor];
        lbl_username.textAlignment = NSTextAlignmentLeft;
        lbl_username.text =[tempDataArray objectAtIndex:0];
        [lbl_username sizeToFit];
        [cell addSubview:lbl_username];
        
        UILabel *lbl_gratuityAmount = [[UILabel alloc] initWithFrame:CGRectMake(srLbl_width+nameLbl_width,0,totalAmountLbl_width,40)];
        [lbl_gratuityAmount setFont:[UIFont fontWithName:GZFont size:11.0]];
        lbl_gratuityAmount.textAlignment = NSTextAlignmentCenter;
        lbl_gratuityAmount.numberOfLines = 0;
        lbl_gratuityAmount.backgroundColor = [UIColor clearColor];
        lbl_gratuityAmount.text = [[tempDataArray objectAtIndex:2] stringValue];
        [cell addSubview:lbl_gratuityAmount];
        
        UILabel *lbl_received = [[UILabel alloc] initWithFrame:CGRectMake(srLbl_width+nameLbl_width+totalAmountLbl_width,0,receivedAmountLbl_width,40)];
        [lbl_received setFont:[UIFont fontWithName:GZFont size:10.0]];
        lbl_received.textAlignment = NSTextAlignmentCenter;
        lbl_received.numberOfLines = 0;
        lbl_received.backgroundColor = [UIColor clearColor];
        lbl_received.text=[[tempDataArray objectAtIndex:3] stringValue];
        lbl_received.lineBreakMode =NSLineBreakByWordWrapping;
        [cell addSubview:lbl_received];
        
        UILabel *lbl_donated = [[UILabel alloc] initWithFrame:CGRectMake(srLbl_width+nameLbl_width+totalAmountLbl_width+receivedAmountLbl_width+4,0,42,40)];
        [lbl_donated setFont:[UIFont fontWithName:GZFont size:11.0]];
        lbl_donated.textAlignment = NSTextAlignmentCenter;
        lbl_donated.numberOfLines = 0;
        lbl_donated.backgroundColor = [UIColor clearColor];
        lbl_donated.text=[[tempDataArray objectAtIndex:4] stringValue];
        lbl_donated.lineBreakMode =NSLineBreakByWordWrapping;
        [cell addSubview:lbl_donated];
        
        UIButton *previewButton=[UIButton buttonWithType:UIButtonTypeCustom];
        previewButton.frame=CGRectMake(srLbl_width+nameLbl_width+totalAmountLbl_width+receivedAmountLbl_width+42,3, 50, 40);
        [previewButton setImage:[UIImage imageNamed:@"details"] forState:UIControlStateNormal];
        [previewButton addTarget:self action:@selector(detailViewAction:) forControlEvents:UIControlEventTouchUpInside];
        [previewButton setTag:indexPath.row];
        [cell addSubview:previewButton];
        
        UIView* horizontalview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 318, 1)];
        horizontalview.backgroundColor = [UIColor whiteColor];
        horizontalview.tag = 9;
        [cell addSubview:horizontalview];
       
        
        UIView* hSeparatorview1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 50)];
        hSeparatorview1.backgroundColor = [UIColor whiteColor];
        hSeparatorview1.tag = 1;
        [cell addSubview:hSeparatorview1];
        
        UIView* hSeparatorview2 = [[UIView alloc] initWithFrame:CGRectMake(srLbl_width+1, 0, 1, 50)];
        hSeparatorview2.backgroundColor = [UIColor whiteColor];
        hSeparatorview2.tag = 2;
        [cell addSubview:hSeparatorview2];
        
        UIView* hSeparatorview3 = [[UIView alloc] initWithFrame:CGRectMake(srLbl_width+nameLbl_width+2, 0, 1, 50)];
        hSeparatorview3.backgroundColor = [UIColor whiteColor];
        hSeparatorview3.tag = 3;
        [cell addSubview:hSeparatorview3];
        UIView* hSeparatorview4 = [[UIView alloc] initWithFrame:CGRectMake(srLbl_width+nameLbl_width+totalAmountLbl_width+3, 0, 1, 50)];
        hSeparatorview4.backgroundColor = [UIColor whiteColor];
        hSeparatorview4.tag = 4;
        [cell addSubview:hSeparatorview4];
        UIView* hSeparatorview5 = [[UIView alloc] initWithFrame:CGRectMake(srLbl_width+nameLbl_width+totalAmountLbl_width+receivedAmountLbl_width+5, 0, 1, 50)];
        hSeparatorview5.backgroundColor = [UIColor whiteColor];
        hSeparatorview5.tag = 5;
        [cell addSubview:hSeparatorview5];
        UIView* hSeparatorview6 = [[UIView alloc] initWithFrame:CGRectMake(srLbl_width+nameLbl_width+totalAmountLbl_width+receivedAmountLbl_width+donatedAmountLbl_width+9, 0, 1, 50)];
        hSeparatorview6.backgroundColor = [UIColor whiteColor];
        hSeparatorview6.tag = 6;
       // [cell addSubview:hSeparatorview6];
        UIView* hSeparatorview7 = [[UIView alloc] initWithFrame:CGRectMake(317, 0, 1, 40)];
        hSeparatorview7.backgroundColor = [UIColor whiteColor];
        hSeparatorview7.tag = 7;
        [cell addSubview:hSeparatorview7];
        
        
        if(indexPath.row==[historyDataArray count]-1){
            NSLog(@"last cell");
            UIView* horizontalfooterview = [[UIView alloc] initWithFrame:CGRectMake(0, 39, 318, 1)];
            horizontalfooterview.backgroundColor = [UIColor whiteColor];
            
            horizontalfooterview.tag = 8;
            [cell addSubview:horizontalfooterview];
        }
    }
    return cell;
    
 }

-(IBAction)detailViewAction:(id)sender{
    
    NSLog(@"sender tag:%d",[sender tag]);
     NSArray *tempDataArray=[historyDataArray objectAtIndex:[sender tag]];
    NSLog(@"details of:%@",tempDataArray);
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLServiceProviderDetailHistory]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    NSDictionary *serviceProviderDetailHistory=[[NSDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"],@"service_providerId",[[tempDataArray objectAtIndex:1] stringValue],@"sender_id", nil];
    [request appendPostData:[[NSString stringWithFormat:@"%@",serviceProviderDetailHistory] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"%@",serviceProviderDetailHistory);
    [request setCompletionBlock:^{
        NSMutableDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
        NSLog(@"details history root%@",root);
        [self intializeHistoryData:root[@"detailsHistory"] tag:2 completionBlock:^(BOOL result) {
            
            if(result){
                historyVC.ischarity=isCharity;
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
    return 40.0f;
}

@end
