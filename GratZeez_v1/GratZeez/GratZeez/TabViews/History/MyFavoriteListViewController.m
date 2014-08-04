//
//  MyFavoriteListViewController.m
//  GratZeez
//
//  Created by cloudZon Infosoft on 28/11/13.
//  Copyright (c) 2013 cloudZon Infosoft. All rights reserved.
//

#import "MyFavoriteListViewController.h"

@interface MyFavoriteListViewController ()

@end

@implementation MyFavoriteListViewController
@synthesize favArray,favToolbar;
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])self.edgesForExtendedLayout = UIRectEdgeNone;
    favArray=[[NSMutableArray alloc]init];
    favArray=[MyAppDelegate.searchResultArray mutableCopy];
    NSLog(@"fav array====>%@",favArray);
    self.view.backgroundColor=RGB(210, 200, 191);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.title=@"Favorite List";
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    [[UIBarButtonItem appearance] setTitleTextAttributes:textAttributesTabBar forState:UIControlStateNormal];
    
    favToolbar.frame=CGRectMake(0,524, 320, 44);
    [self.view addSubview:favToolbar];
    UIButton *backBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 36, 21)];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    UIBarButtonItem *btnitem=[[UIBarButtonItem alloc]initWithCustomView:backBtn];
    favToolbar.items=@[btnitem];
    [favToolbar setBackgroundImage:toolBarImage forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
    [self addLeftMenuButtonWithImage:[UIImage imageNamed:@"menu_icon"]];
    [self addrightMenuButtonWithImage:[UIImage imageNamed:@"help"]];
    UISwipeGestureRecognizer *rightSwipe=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(rightSwipeHandle:)];
    rightSwipe.direction=UISwipeGestureRecognizerDirectionRight;
    rightSwipe.numberOfTouchesRequired=1;
    [self.view addGestureRecognizer:rightSwipe];
}
-(IBAction)rightSwipeHandle:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(IBAction)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return [favArray count];
}
-(UIView *)selectedCellView{
    UIView *cellView=[[UIView alloc]init];
    cellView.backgroundColor=RGB(155,130,110);
    return cellView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    tableView.separatorInset=UIEdgeInsetsZero;
    tableView.separatorColor=[UIColor whiteColor];
    tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    NSArray *tempSearchArray=[favArray objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"SearchResultCell";
    SearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *topLevelObject;
        topLevelObject = [[NSBundle mainBundle] loadNibNamed:@"SearchResultCell" owner:self options:nil];
        cell = [topLevelObject objectAtIndex:0];
    }
    // Configure the cell...
    cell.lblFirst_name.text=[[tempSearchArray objectAtIndex:2] stringByAppendingFormat:@"  %@",[tempSearchArray  objectAtIndex:3]];//@"vivek";
    cell.lblFirst_name.font=[UIFont fontWithName:GZFont size:14.0f];
   // cell.lblLast_name.text=[tempSearchArray  objectAtIndex:3];//@"Patel";
   // cell.lblNumber.text=[tempSearchArray objectAtIndex:1];//@"123456";
    cell.lblNumber.text = [tempSearchArray objectAtIndex:9];//@"Hotel";
    cell.lblNumber.font=[UIFont fontWithName:GZFont size:14];
    cell.lblUsername.text=[tempSearchArray objectAtIndex:0];//@"GZ_Vivek";
    cell.lblUsername.font=[UIFont fontWithName:GZFont size:14];
    cell.backgroundColor=RGB(210, 200, 191);
    cell.selectedBackgroundView=[self selectedCellView];
    UIView *line=[[UIView alloc]initWithFrame:CGRectMake(0, 99, 320, 1)];
    line.backgroundColor=[UIColor whiteColor];
    [cell.contentView addSubview:line];
    if ([[tempSearchArray objectAtIndex:7] boolValue]==1) {
        DYRateView *rateView = [[DYRateView alloc] initWithFrame:CGRectMake(90, 73, 120, 20)
                                                        fullStar:[UIImage imageNamed:@"StarFullLarge.png"]
                                                       emptyStar:[UIImage imageNamed:@"StarEmptyLarge.png"]];
        rateView.padding = 2;
        rateView.rate =[[tempSearchArray objectAtIndex:5] floatValue];
        //NSLog(@"rating value%f",[[tempSearchArray objectAtIndex:4] floatValue]);
        rateView.alignment = RateViewAlignmentCenter;
        rateView.editable = NO;
        [cell.contentView addSubview:rateView];
    }
    NSString *urlString=[ImageURL stringByAppendingPathComponent:[tempSearchArray objectAtIndex:6]];
    cell.imgIcon.image=[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]]];
    UIButton *cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.frame=CGRectMake(280, 10, 20, 20);
    [cancelButton setImage:[UIImage imageNamed:@"cancel"] forState:UIControlStateNormal];
    [cancelButton setTag:indexPath.row];
    [cancelButton addTarget:self action:@selector(cancelButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:cancelButton];
    return cell;
}

-(IBAction)cancelButtonClicked:(id)sender{
    NSLog(@"cancel");
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLAddAsFavorite]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    NSLog(@"tag%d",[sender tag]);
    NSLog(@"array%@",[favArray objectAtIndex:[sender tag]]);
    NSArray *deleteArray=[favArray objectAtIndex:[sender tag]];
    NSLog(@"tage%@",[deleteArray objectAtIndex:4]);
    NSDictionary *favoriteDictionary=[[NSDictionary alloc]initWithObjectsAndKeys:@"false",@"isFavorite",[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"],@"sender_id",[deleteArray objectAtIndex:4],@"service_providerId", nil];
    [request appendPostData:[[NSString stringWithFormat:@"%@",favoriteDictionary] dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"sent%@",favoriteDictionary);
    [request setCompletionBlock:^{
    NSDictionary *root = [NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
    NSLog(@"Rate root%@",root);
        //   [self.navigationController popToRootViewControllerAnimated:YES];
    [favArray removeObjectAtIndex:[sender tag]];
    NSLog(@"updated favArray====>%@",favArray);
    [MyAppDelegate.searchResultArray removeObjectAtIndex:[sender tag]];
    [favArray count];
    if([favArray count]<=0){
        [self.navigationController popViewControllerAnimated:YES];
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                            type:AJNotificationTypeBlue
                                           title:[root objectForKey:@"message"]
                                 linedBackground:AJLinedBackgroundTypeDisabled
                                       hideAfter:GZAJNotificationDelay];
            return ;
        }
        [favTable reloadData];
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeBlue
                                       title:[root objectForKey:@"message"]
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        [AJNotificationView showNoticeInView:[[UIApplication sharedApplication] delegate].window
                                        type:AJNotificationTypeRed
                                       title:error.localizedDescription
                             linedBackground:AJLinedBackgroundTypeDisabled
                                   hideAfter:GZAJNotificationDelay];
        return ;
    }];
    [request startAsynchronous];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}



#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    SearchedProfileViewController *resultVC = [[SearchedProfileViewController alloc] initWithNibName:@"SearchedProfileViewController" bundle:nil];
//    resultVC.cellId=indexPath.row;
//    resultVC.isFavorite=1;
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    resultVC.cellId=indexPath.row;
    ASIFormDataRequest *_request = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:URLGetIsFavorite]];
    __unsafe_unretained ASIFormDataRequest *request = _request;
    [request setDelegate:self];
    NSArray *objectArray=[favArray objectAtIndex:indexPath.row];
    NSDictionary *serviceProviderInfoDict=[[NSDictionary alloc]initWithObjectsAndKeys:[objectArray objectAtIndex:4],@"serviceProviderId",[[NSUserDefaults standardUserDefaults] valueForKey:@"userid"],@"senderId", nil];
    NSLog(@"serviceDict:%@",serviceProviderInfoDict);
    NSError *error;
    NSData *favData=[NSJSONSerialization dataWithJSONObject:serviceProviderInfoDict options:NSJSONWritingPrettyPrinted error:&error];
    [request appendPostData:favData];
    [request addRequestHeader:ContentType value:ContentTypeValue];
    [request setCompletionBlock:^{
        NSDictionary *root=[NSJSONSerialization JSONObjectWithData:[request responseData] options:0 error:nil];
        NSLog(@"info root%@",root);
        NSDictionary *dataDict;
        if([root[@"data"] count]==0){
            
        }
        else{
            dataDict=root[@"data"];
            resultVC.isFavorite=[dataDict[@"isFavourite"] boolValue];
            resultVC.individualRate=dataDict[@"rating"];
            if(dataDict[@"amountToCharity"]==0){
                resultVC.amountToCharity=0;
            }
            else{
                resultVC.amountToCharity=[dataDict[@"amountToCharity"] integerValue];
            }
            [self.navigationController pushViewController:resultVC animated:YES];
            
        }
        
    }];
    [request startAsynchronous];
   // [self.navigationController pushViewController:resultVC animated:YES];
}
 
 

@end
